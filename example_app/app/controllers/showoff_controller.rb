class ShowoffController < ApplicationController
  include Sinatrify::DSL

  get "/greet" do
    render :text => "hello"
  end
end
