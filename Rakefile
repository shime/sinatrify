#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

begin
  require "cucumber/rake/task"
rescue LoadError
end

require "appraisal"

task :appraise => ["appraisal:install"] do
  exec 'rake appraisal cucumber'
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Sinatrify'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "--tags ~@wip"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  system("rspec spec")
end

task :default do
end
