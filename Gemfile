# frozen_string_literal: true

source "https://rubygems.org"

gemspec

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version) { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == "ruby" }
linting = minimum_version.call("2.6")
coverage = minimum_version.call("2.6")
debug = minimum_version.call("2.4")
if linting
  gem "danger", "~> 8.4"
  gem "rubocop", "~> 1.22"
  gem "rubocop-faker", "~> 1.1"
  gem "rubocop-md", "~> 1.0"
  gem "rubocop-minitest", "~> 0.15"
  gem "rubocop-packaging", "~> 0.5"
  gem "rubocop-performance", "~> 1.11"
  gem "rubocop-rake", "~> 0.6"
  gem "rubocop-thread_safety", "~> 0.4"
end
if coverage
  gem "simplecov", "~> 0.21"
  gem "simplecov-cobertura", "~> 1.4"
end
gem "byebug", "~> 11.1" if debug
