
require 'ostruct'
App = OpenStruct.new({
  :host => "graphite",
  :timez => %w(10min 30min 60min 3hours 6hours 12hours 24hours 1week 1month),
})

Graph.define do |g|
  g.title  "Twitter action"
  g.target "stats.twitter.halloween"
  g.target "stats.twitter.obama"
  g.target "stats.twitter.rchh"
end

Graph.define do |g|
  g.title  "Ping battle"
  g.vtitle  "ms"
  g.target "stats.timers.pingtime.wimdu.com.mean"
  g.target "stats.timers.pingtime.simfy.de.mean"
end

