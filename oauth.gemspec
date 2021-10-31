# -*- encoding: utf-8 -*-

lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "oauth/version"

Gem::Specification.new do |spec|
  spec.name    = "oauth"
  spec.version = OAuth::VERSION
  spec.license = "MIT"

  spec.authors     = ["Pelle Braendgaard", "Blaine Cook", "Larry Halff", "Jesse Clark", "Jon Crosby", "Seth Fitzsimmons", "Matt Sanford", "Aaron Quint"]
  spec.email       = "oauth-ruby@googlegroups.com"
  spec.summary     = "OAuth Core Ruby implementation"

  spec.executables = ["oauth"]
  spec.homepage = "https://github.com/oauth-xx/oauth-ruby"
  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/master/HISTORY",
    "documentation_uri" => "https://rubydoc.info/github/oauth-xx/oauth-ruby/master",
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage
  }
  spec.files       = Dir.glob("lib/**/*.rb") + ["LICENSE", "README.rdoc", "HISTORY"]
  #spec.test_files  = Dir.glob("test/**/*.rb") + Dir.glob('test/keys/*')
  spec.extra_rdoc_files = [ "LICENSE", "README.rdoc", "TODO" ]

  # This gem will work with 2.0 or greater...
  spec.required_ruby_version = ">= 2.0"

  ruby_version = Gem::Version.new(RUBY_VERSION)
  minimum_version = ->(version) { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == "ruby" }
  linting = minimum_version.call("2.6")
  coverage = minimum_version.call("2.6")
  debug = minimum_version.call("2.4")

  # Nokogiri 1.7 does not accept Ruby 2.0
  spec.add_development_dependency("nokogiri", "~> 1.12.5") if ruby_version < Gem::Version.new("2.0")

  spec.add_development_dependency("actionpack", ">= 5.0")
  spec.add_development_dependency("byebug", "~> 11.1") if debug
  spec.add_development_dependency("curb")
  spec.add_development_dependency("em-http-request", "~> 1.1.7")
  spec.add_development_dependency("iconv")
  spec.add_development_dependency("minitest")
  spec.add_development_dependency("mocha", ">= 0.9.12", "<=1.1.0")
  spec.add_development_dependency("rack", "~> 2.0")
  spec.add_development_dependency("rack-test")
  spec.add_development_dependency("rake", "~> 13.0")
  spec.add_development_dependency("rest-client")
  if linting
    spec.add_development_dependency("rubocop", "~> 1.22")
    spec.add_development_dependency("rubocop-faker", "~> 1.1")
    spec.add_development_dependency("rubocop-md", "~> 1.0")
    spec.add_development_dependency("rubocop-minitest", "~> 0.15")
    spec.add_development_dependency("rubocop-packaging", "~> 0.5")
    spec.add_development_dependency("rubocop-performance", "~> 1.11")
    spec.add_development_dependency("rubocop-rake", "~> 0.6")
    spec.add_development_dependency("rubocop-thread_safety", "~> 0.4")
  end
  if coverage
    spec.add_development_dependency("simplecov", "~> 0.21")
    spec.add_development_dependency("simplecov-cobertura", "~> 1.4")
  end
  spec.add_development_dependency("typhoeus", ">= 0.1.13")
  spec.add_development_dependency("webmock", "<= 3.14.0")
end
