Very simple 'dashboard' for Graphite, with Graphs being defined in Ruby

```ruby
  Graph.define do |g|
    g.title "Twitter action"
    g.target "stats.twitter.halloween"
    g.target "stats.twitter.spring"
  end
```

## Usage
1. Edit config.rb (graphite host location, define graphs)
   See http://readthedocs.org/docs/graphite/en/latest/url-api.html for options.
2. bundle install
3. bundle exec shotgun stats.rb
4. open http://localhost:9393/
