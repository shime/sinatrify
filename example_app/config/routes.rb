ExampleApp::Application.routes.draw do
  mount lambda {|env| ShowoffController.call(env)} => "/api"
end
