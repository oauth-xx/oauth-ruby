# -*- encoding: utf-8 -*-

lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "oauth/version"

Gem::Specification.new do |spec|
  spec.name    = "oauth"
  spec.version = OAuth::VERSION
  spec.license = "MIT"

  spec.authors     = ["Pelle Braendgaard", "Blaine Cook", "Larry Halff", "Jesse Clark", "Jon Crosby", "Seth Fitzsimmons", "Matt Sanford", "Aaron Quint"]
  spec.email       = "oauth-ruby@googlegroupspec.com"
  spec.summary     = "OAuth Core Ruby implementation"

  spec.executables = ["oauth"]
  spec.homepage = "https://github.com/oauth-xx/oauth-ruby"
  spec.metadata = {
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'changelog_uri' => "#{spec.homepage}/blob/master/HISTORY",
    'documentation_uri' => "https://rdoc.info/github/oauth-xx/oauth-ruby/master/frames",
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage
  }
  spec.files       = Dir.glob("lib/**/*.rb")
  #spec.test_files  = Dir.glob("test/**/*.rb") + Dir.glob('test/keys/*')
  spec.extra_rdoc_files = [ "LICENSE", "README.rdoc", "TODO" ]

  # This gem will work with 2.0 or greater...
  spec.required_ruby_version = '>= 2.0'

  # Nokogiri 1.7 does not accept Ruby 2.0
  spec.add_development_dependency("nokogiri", "~> 1.11.6") if RUBY_VERSION < "2.1"

  spec.add_development_dependency("rake")
  spec.add_development_dependency("minitest")
  spec.add_development_dependency("byebug")
  spec.add_development_dependency("actionpack", ">= 5.0")
  spec.add_development_dependency("iconv")
  spec.add_development_dependency("rack", "~> 2.0")
  spec.add_development_dependency("rack-test")
  spec.add_development_dependency("mocha", ">= 0.9.12", "<=1.1.0")
  spec.add_development_dependency("typhoeus", ">= 0.1.13")
  spec.add_development_dependency("em-http-request", "0.2.11")
  spec.add_development_dependency("curb")
  spec.add_development_dependency("webmock", "< 2.0")
  spec.add_development_dependency("codeclimate-test-reporter")
  spec.add_development_dependency("simplecov")
  spec.add_development_dependency("rest-client")
end
