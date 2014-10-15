%w[rubygems rake rake/clean rake/testtask fileutils bundler].each { |f| require f }

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*test*.rb']
  t.verbose = true
end

Dir['tasks/**/*.rake'].each { |t| load t }

task :default => :test
