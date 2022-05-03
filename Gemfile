source "https://rubygems.org"

gemspec

gem "actionpack"

# Those lines need to be added
plugin 'diffend'
# Monitor is required for production realtime notifications
gem 'diffend-monitor', require: %w[diffend/monitor]

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version) { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == "ruby" }
linting = minimum_version.call("2.0")
danger = minimum_version.call("2.7")
coverage = minimum_version.call("2.7")
debug = minimum_version.call("2.4")
overcommit = minimum_version.call("2.4")
if overcommit
  gem "overcommit", "~> 0.58"
end
if danger
  gem "danger", "~> 8.4"
end
if linting
  gem "rubocop-md"
  gem "rubocop-minitest"
  gem "rubocop-ruby2_0", "~> 1.0"
  gem "rubocop-thread_safety"
end
if coverage
  gem "simplecov", "~> 0.21"
  gem "simplecov-cobertura", "~> 2.1"
end
gem "byebug", "~> 11.1" if debug
