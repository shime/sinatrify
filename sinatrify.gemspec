# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sinatrify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sinatrify"
  s.version     = Sinatrify::VERSION
  s.authors     = ["Hrvoje Šimić"]
  s.email       = ["shime.ferovac@gmail.com"]
  s.homepage    = "http://shime.github.com/"
  s.summary     = "Make Rails controller actions look like Sinatra routes"

  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "actionpack",       ">= 3.0.0"
  s.add_dependency "activesupport",    ">= 3.0.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"

  # cool terminal inside cucumber features
  # for more info check: https://github.com/cucumber/aruba/
  s.add_development_dependency "aruba"      
  s.add_development_dependency "cucumber"

  s.add_development_dependency "appraisal" # thanks Thoughtbot!
end
