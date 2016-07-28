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
  spec.files       = Dir.glob("lib/**/*.rb")
  spec.test_files  = Dir.glob("test/**/*.rb")
  spec.extra_rdoc_files = [ "LICENSE", "README.rdoc", "TODO" ]

  spec.add_development_dependency("rake")
  spec.add_development_dependency("minitest", '>= 5.0')
  spec.add_development_dependency("byebug")
  spec.add_development_dependency("actionpack")
  spec.add_development_dependency("iconv")
  spec.add_development_dependency("rack")
  spec.add_development_dependency("rack-test")
  spec.add_development_dependency("mocha", ">= 0.9.12")
  spec.add_development_dependency("typhoeus", ">= 0.1.13")
  spec.add_development_dependency("em-http-request", "0.2.11")
  spec.add_development_dependency("curb")
  spec.add_development_dependency("webmock", "< 2.0")
  spec.add_development_dependency 'codeclimate-test-reporter'
end
