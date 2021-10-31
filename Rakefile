# frozen_string_literal: true

require "bundler/gem_tasks"
%w[rake/testtask fileutils].each { |f| require f }

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*test*.rb"]
  t.verbose = true
end

begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    warn "RuboCop is disabled on Ruby #{RUBY_VERSION}"
  end
end

task default: %i[test rubocop]
