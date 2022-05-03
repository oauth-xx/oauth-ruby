source "https://rubygems.org"

gemspec

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version) { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == "ruby" }
linting = minimum_version.call("2.6")
coverage = minimum_version.call("2.6")
debug = minimum_version.call("2.4")
if linting
  gem "danger", "~> 8.4"
  gem "overcommit", "~> 0.58"
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
