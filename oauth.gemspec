lib = File.expand_path("../lib/", __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require "oauth/version"

Gem::Specification.new do |spec|
  spec.name    = "oauth"
  spec.version = OAuth::VERSION
  spec.license = "MIT"

  spec.authors     = ["Pelle Braendgaard", "Blaine Cook", "Larry Halff", "Jesse Clark", "Jon Crosby", "Seth Fitzsimmons", "Matt Sanford", "Aaron Quint", "Peter Boling"]
  spec.email       = "oauth-ruby@googlegroups.com"
  spec.summary     = "OAuth Core Ruby implementation"

  spec.executables = ["oauth"]
  spec.homepage = "https://github.com/oauth-xx/oauth-ruby"
  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/github/oauth-xx/oauth-ruby/main",
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }
  spec.files = Dir.glob("lib/**/*.rb") + ["LICENSE", "README.md", "CHANGELOG.md", "CODE_OF_CONDUCT.md", "SECURITY.md", "CONTRIBUTING.md"]
  spec.extra_rdoc_files = ["TODO"]

  # This gem will work with Ruby 2.0 or greater...
  spec.required_ruby_version = ">= 2.0"

  spec.add_development_dependency("curb")
  spec.add_development_dependency("em-http-request", "~> 1.1.7")
  spec.add_development_dependency("iconv")
  spec.add_development_dependency("minitest", "~> 5.15.0")
  spec.add_development_dependency("mocha")
  spec.add_development_dependency("rack")
  spec.add_development_dependency("rack-test")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rest-client")
  spec.add_development_dependency("rubocop-lts", "~> 4.0")
  spec.add_development_dependency("typhoeus", ">= 0.1.13")
  spec.add_development_dependency("webmock", "<= 3.14.0")
end
