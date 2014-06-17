require 'sinatra'
require 'i18n'
require 'active_support/all'

class Graph

  def title(title=nil)
    if title
      self.params[:title] = title 
    end
    self.params[:title]
  end

  def id
    self.title.parameterize
  end

  def targets
    @targets ||= {}
  end

  def params
    @params ||= {}
  end

  def to_url(params = {})
    time = (params[:time] || '60min').strip
    time = "-#{time}" unless time =~ /^[-]/
    "http://#{App.host}/render?#{to_param}&from=#{time}"
  end



  def self.define
    new_graph = Graph.new
    yield(new_graph)
    new_graph.title.present? || raise('Need a title, Sir.')
    graphs << new_graph
  end

  def self.graphs
    @@graphs ||= []
  end

  def target(target_name, *args)
    opts = args.pop
    self.targets[target_name] = opts
  end

  def param(param_hash)
    self.params.merge!(param_hash)
  end

  def vtitle(vtitle)
    self.params[:vtitle] = vtitle
  end

  private
  def to_param
    # http://readthedocs.org/docs/graphite/en/latest/url-api.html
    "target=#{targets_params}&#{default_params.merge(params).to_param}"
  end

  def default_params
    {
      :template => "plain",
      :width => 1000,
      :height => 300,
      :tz=> App.timezone,
      :fontSize => '11',
      :min => 0,
      :format => "svg",
    }
  end

  def targets_params
    target_names.join("&target=")
  end

  def target_names
    targets.keys
  end
end

if config_file = ENV["GLMB_CONFIG"]
  require config_file
else
  require_relative 'config.rb'
end

get '/' do
  @graphs = Graph.graphs
  erb :index
end

get '/graphs/?' do
  @graphs = Graph.graphs
  erb :index
end

get '/graphs/:id/?' do |id|
  @graph = Graph.graphs.find { |g| g.id == id }
  if @graph then erb(:detail) else halt(404, 'Graph not found :(') end
end
