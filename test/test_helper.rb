# ensure test env

ENV["RACK_ENV"] = "test"

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version) { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == "ruby" }
coverage = minimum_version.call("2.6")
debug = minimum_version.call("2.4")

if coverage
  require "simplecov"
  require "simplecov-cobertura"
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter unless ENV["HTML_COVERAGE"] == "true"
end

# require third-party code
require "byebug" if debug
require "stringio"
require "minitest/autorun"
require "minitest/unit"
require "mocha/minitest"
require "rack/test"
require "webmock/minitest"

# require our lib
require "oauth"

# require our support code

require "support/minitest_helpers"
