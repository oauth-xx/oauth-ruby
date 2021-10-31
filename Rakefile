# frozen_string_literal: true

require "bundler/gem_tasks"
%w[rake/testtask fileutils].each { |f| require f }

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*test*.rb"]
  t.verbose = true
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test rubocop]
