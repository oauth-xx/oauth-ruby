# frozen_string_literal: true

require_relative "lib/oauth/version"

Gem::Specification.new do |spec|
  spec.add_dependency("version_gem", "~> 1.1")

  spec.name    = "oauth"
  spec.version = OAuth::Version::VERSION
  spec.license = "MIT"

  spec.authors     = ["Pelle Braendgaard", "Blaine Cook", "Larry Halff", "Jesse Clark", "Jon Crosby",
                      "Seth Fitzsimmons", "Matt Sanford", "Aaron Quint", "Peter Boling"]
  spec.email       = "oauth-ruby@googlegroups.com"
  spec.summary     = "OAuth Core Ruby implementation"

  spec.executables = ["oauth"]
  spec.homepage = "https://github.com/oauth-xx/oauth-ruby"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/wiki"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.glob("lib/**/*.rb") + ["LICENSE", "README.md", "CHANGELOG.md", "CODE_OF_CONDUCT.md", "SECURITY.md", "CONTRIBUTING.md"]
  spec.extra_rdoc_files = ["TODO"]

  spec.required_ruby_version = ">= 2.4"

  spec.add_development_dependency("em-http-request", "~> 1.1.7")
  spec.add_development_dependency("iconv")
  spec.add_development_dependency("minitest", "~> 5.15.0")
  spec.add_development_dependency("mocha")
  spec.add_development_dependency("rack", "~> 2.0")
  spec.add_development_dependency("rack-test")
  spec.add_development_dependency("rake", "~> 13.0")
  spec.add_development_dependency("rest-client")
  spec.add_development_dependency("rubocop-lts", "~> 12.0")
  spec.add_development_dependency("typhoeus", ">= 0.1.13")
  spec.add_development_dependency("webmock", "<= 3.14.0")
end
