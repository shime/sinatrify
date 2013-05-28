Feature: Sinatrify is cool

  When Sinatrify is included inside a Rails app, it provides a
  Sinatra-like DSL that makes building an API much easier

  Background: Create new rails app
    Given I successfully run `rails new example_app --skip-gemfile -O`
    And I cd to "example_app"
    And I remove the file "config/routes.rb"
    And I append to "config/routes.rb" with:
    """
      ExampleApp::Application.routes.draw do
        mount lambda {|env| ExampleController.call(env) } => "/edith"
      end
    """

  Scenario: I can use the new actions
    When I append to "app/controllers/example_controller.rb" with:
    """
      class ExampleController < ApplicationController
        include Sinatrify::DSL

        get "/sing" do
          render :text => "Non, je ne regrette rien..."
        end
      end
    """
    And I append to "mock_request.rb" with:
    """
      require File.expand_path('../config/environment', __FILE__)

      app      = ExampleApp::Application
      request  = Rack::MockRequest.new(app)
      response = request.get("/edith/sing")

      puts "Edith: '#{response.body}'"
    """
    And I run `rails runner mock_request.rb`
    Then the output should contain "Edith: 'Non, je ne regrette rien...'"

  Scenario: Actions should be verb-sensitive
    When I append to "app/controllers/example_controller.rb" with:
    """
      class ExampleController < ApplicationController
        include Sinatrify::DSL

        get "/sing" do
          render :text => "Non, je ne regrette rien..."
        end

        post "/" do
          render :text => params[:song]
        end
      end
    """
    And I append to "mock_request.rb" with:
    """
      require File.expand_path('../config/environment', __FILE__)

      app      = ExampleApp::Application
      request  = Rack::MockRequest.new(app)
      response = request.post("/edith/sing", :params => {:song => "I did it my way"})

      puts "STATUS: #{response.status}"
    """
    And I run `rails runner mock_request.rb`
    Then the output should contain "STATUS: 404"
    And I remove the file "mock_request.rb"
    And I append to "mock_request.rb" with:
    """
      require File.expand_path('../config/environment', __FILE__)

      app      = ExampleApp::Application
      request  = Rack::MockRequest.new(app)
      response = request.post("/edith",:params => {:song => "I did it my way"})

      puts "Edith: '#{response.body}'"
    """
    And I run `rails runner mock_request.rb`
    Then the output should contain "Edith: 'I did it my way'"


  Scenario: Pattern matching should work
    When I append to "app/controllers/example_controller.rb" with:
    """
      class ExampleController < ApplicationController
        include Sinatrify::DSL

        get "/song(/:name)" do
          if params[:name]
            render :text => params[:name]
          else
            render :text => "Non, je ne regrette rien..."
          end
        end
      end
    """
    And I append to "mock_request.rb" with:
    """
      require File.expand_path('../config/environment', __FILE__)

      app      = ExampleApp::Application
      request  = Rack::MockRequest.new(app)
      response = request.get("/edith/song")

      puts "Edith: '#{response.body}'"
    """
    And I run `rails runner mock_request.rb`
    Then the output should contain "Edith: 'Non, je ne regrette rien...'"
    And I remove the file "mock_request.rb"
    And I append to "mock_request.rb" with:
    """
      require File.expand_path('../config/environment', __FILE__)

      app      = ExampleApp::Application
      request  = Rack::MockRequest.new(app)
      response = request.get("/edith/song/hi")

      puts "Edith: '#{response.body}'"
    """
    And I run `rails runner mock_request.rb`
    Then the output should contain "Edith: 'hi'"
