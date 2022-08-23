# frozen_string_literal: true

source "https://rubygems.org"

gemspec

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Curb has trouble building native extentions on Windows platform
curb = !Gem.win_platform?

gem "pry", platforms: %i[mri jruby]
platforms :mri do
  gem "codecov", "~> 0.6" # For CodeCov
  gem "overcommit", "~> 0.58"
  gem "rubocop-faker"
  gem "rubocop-md"
  gem "rubocop-minitest"
  gem "rubocop-packaging"
  gem "rubocop-performance"
  gem "rubocop-rake"
  gem "rubocop-thread_safety"
  gem "simplecov", "~> 0.21", require: false
  gem "simplecov-cobertura" # XML for Jenkins
  gem "simplecov-json" # For CodeClimate
  gem "simplecov-lcov", "~> 0.8", require: false

  # Add `byebug` to your code where you want to drop to REPL, and add DEBUG=true when running tests
  gem "byebug"
  # WebMock is known to work with Curb >= 0.7.16, < 0.10, except versions 0.8.7
  gem "curb", [">= 0.7.16", "< 0.10", "!= 0.8.7"] if curb
  gem "pry-byebug"
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
