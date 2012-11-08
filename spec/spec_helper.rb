ENV['RAILS_ENV'] ||= 'test'

PROJECT_ROOT = File.expand_path('../..', __FILE__)
$LOAD_PATH << File.join(PROJECT_ROOT, 'lib')

require "active_support/core_ext"

require "action_dispatch"

Bundler.require

class Base
  include Sinatrify::DSL
end

class MockRouter
  def call(env)
    "called with #{env}"
  end
end
