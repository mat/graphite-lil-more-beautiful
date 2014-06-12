
require 'ostruct'
App = OpenStruct.new({
  :host => "graphite",
  :timez => %w(60min 6hours 24hours 1week 1month),
})

Graph.define do |g|
  g.title  "Twitter action"
  g.target "stats.twitter.halloween"
  g.target "stats.twitter.obama"
  
  g.target "sum(stats.twitter.halloween,stats.twitter.spring)"
end

Graph.define do |g|
  g.title  "Ping battle"
  g.vtitle  "ms"
  g.target "stats.timers.pingtime.wimdu.com.mean"
  g.target "stats.timers.pingtime.simfy.de.mean"
end

