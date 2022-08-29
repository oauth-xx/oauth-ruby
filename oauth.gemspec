lib = File.expand_path("../lib/", __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require "oauth/version"

Gem::Specification.new do |spec|
  spec.name    = "oauth"
  spec.version = OAuth::VERSION
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

  # This gem will work with Ruby 2.0 or greater...
  spec.required_ruby_version = ">= 2.0"
  spec.post_install_message = "
You have installed oauth version #{OAuth::VERSION}, congratulations!

Support for the 0.5.x series will end by April, 2023. Please upgrade to 0.6.x or 1.x as soon as possible!
For 0.6.x the only breaking change will be dropped support for Ruby 2.0, 2.1, 2.2, and 2.3.
For 1.x the only breaking change will be dropped support for Ruby 2.4, 2.5, and 2.6.

Please see:
• #{spec.homepage}/blob/main/SECURITY.md

Note also that I am, and this project is, in the process of leaving Github.
I wrote about some of the reasons here:
• https://dev.to/galtzo/im-leaving-github-50ba

If you are a human, please consider a donation as I move toward supporting myself with Open Source work:
• https://liberapay.com/pboling
• https://ko-fi.com/pboling
• https://patreon.com/galtzo

If you are a corporation, please consider supporting this project, and open source work generally, with a TideLift subscription.
• https://tidelift.com/funding/github/rubygems/oauth
• Or hire me. I am looking for a job!

Please report issues, and support the project!

Thanks, |7eter l-|. l3oling

"

  spec.add_development_dependency("curb")
  spec.add_development_dependency("em-http-request", "~> 1.1.7")
  spec.add_development_dependency("iconv")
  spec.add_development_dependency("minitest", "< 5.16")
  spec.add_development_dependency("mocha")
  spec.add_development_dependency("rack")
  spec.add_development_dependency("rack-test")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rest-client")
  spec.add_development_dependency("rubocop-lts", "~> 4.0")
  spec.add_development_dependency("typhoeus", ">= 0.1.13")
  spec.add_development_dependency("webmock", "<= 3.14.0")
end
