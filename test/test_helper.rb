# frozen_string_literal: true

# ensure test env
ENV["RACK_ENV"] = "test"

# Third Party Libraries
require "stringio"
require "minitest/autorun"
require "minitest/unit"
require "mocha/minitest"
require "rack/test"
require "webmock/minitest"

DEBUG = ENV["DEBUG"] == "true"

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version, engine = "ruby") { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == engine }
actual_version = lambda do |major, minor|
  actual = Gem::Version.new(ruby_version)
  major == actual.segments[0] && minor == actual.segments[1] && RUBY_ENGINE == "ruby"
end
debugging = minimum_version.call("2.4") && DEBUG
RUN_COVERAGE = minimum_version.call("2.7") && (ENV["COVER_ALL"] || ENV["CI_CODECOV"] || ENV["CI"].nil?)
ALL_FORMATTERS = actual_version.call(2, 7) && (ENV["COVER_ALL"] || ENV["CI_CODECOV"] || ENV["CI"])

if DEBUG
  if debugging
    require "byebug"
  elsif minimum_version.call("2.4", "jruby")
    require "pry-debugger-jruby"
  end
end

if RUN_COVERAGE
  require "simplecov"
  require "codecov"
  require "simplecov-lcov"
  require "simplecov-cobertura"
end

# This gem
require "oauth"

# Test Support Code
require "support/minitest_helpers"
