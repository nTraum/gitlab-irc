require 'bundler/gem_tasks'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.test_files = Dir.glob 'test/**/*_test.rb'
  t.verbose = true
end