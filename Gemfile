# frozen_string_literal: true

source "https://rubygems.org"

gemspec

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "rake", "~> 13.0"

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version, engine = "ruby") { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == engine }
linting = minimum_version.call("2.6")
coverage = minimum_version.call("2.7")
debug = minimum_version.call("2.4")

gem "pry", platforms: %i[mri jruby]
platforms :mri do
  if linting
    gem "danger", "~> 8.4"
    gem "overcommit", "~> 0.58"
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
    gem "codecov", "~> 0.6"
    gem "simplecov", "~> 0.21", require: false
    gem "simplecov-cobertura" # XML for Jenkins
    gem "simplecov-lcov", "~> 0.8", require: false
  end
  if debug
    # Add `byebug` to your code where you want to drop to REPL
    gem "byebug"
    gem "pry-byebug"
  end
end
platforms :jruby do
  # Add `binding.pry` to your code where you want to drop to REPL
  gem "pry-debugger-jruby"
end

### deps for documentation and rdoc.info
group :documentation do
  gem "github-markup", platform: :mri
  gem "redcarpet", platform: :mri
  gem "yard", require: false
end
