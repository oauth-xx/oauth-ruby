# frozen_string_literal: true

source "https://rubygems.org"

gemspec

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version, engine = "ruby") { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == engine }
linting = minimum_version.call("2.4")
coverage = minimum_version.call("2.7")
diffend = minimum_version.call("2.7")
debug = minimum_version.call("2.4")

gem "pry", platforms: %i[mri jruby]
platforms :mri do
  if diffend
    plugin "diffend"
    # Monitor is required for realtime notifications
    gem "diffend-monitor", require: %w[diffend/monitor]
  end
  if linting
    gem "danger", "~> 8.4"
    gem "overcommit", "~> 0.58"
    gem "rubocop-faker"
    gem "rubocop-md"
    gem "rubocop-minitest"
    gem "rubocop-packaging"
    gem "rubocop-performance"
    gem "rubocop-rake"
    gem "rubocop-ruby2_4", "~> 1.0"
    gem "rubocop-thread_safety"
  end
  if coverage
    gem "codecov", "~> 0.6" # For CodeCov
    gem "simplecov", "~> 0.21", require: false
    gem "simplecov-cobertura" # XML for Jenkins
    gem "simplecov-json" # For CodeClimate
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
