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

GEMFILES = Dir["./gemfiles/*"].map {|f| f.gsub(/^./,`pwd`.strip)}

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
  raise "Rails Gemfile not specified, make sure your BUNDLE_GEMFILE is set to "\
    "a Gemfile from ./gemfiles when running cucumber features." if !GEMFILES.include? ENV["BUNDLE_GEMFILE"]
  t.cucumber_opts = "--tags ~@wip"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  system("rspec spec")
end

task :default => [:test, :cucumber] do
end
