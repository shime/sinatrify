# Sinatrify

Make Rails controllers look like Sinatra.

Heavily inspired by Carl Lerche's "[Astaire](https://github.com/carllerche/astaire)".

The lambda inside Rails routes was taken from Jose Valim's [gist](https://gist.github.com/josevalim/3717973).

```ruby
class ShowoffController < ApplicationController
    
  include Sinatrify::DSL
   
  get "/greet" do
    render :text => "Hello!"
  end
end
```


## Features

* Dress your Rails controller in a classy Sinatra suit
* High test coverage
* Integration tests for every major Rails release

## Installation

Add it to the Gemfile
```ruby
  gem "sinatrify"
```
Bundle it with `bundle`.

Sinatrify doesn't include its DSL into controllers automatically.
You should do so manually for each controller, like in the above example.

Mount your sinatrified controller somewhere
```ruby 
# in config/routes.rb
mount lambda { |env| ShowoffController.call(env) } => "/api"
```

`lambda` is used here so your code gets reloaded in development.

Works on Rails >3.0 only.

## Examples

Check out the *example_app* folder.

## Testing

Run `rake test` for specs and `rake appraise` for features. 

## Contributing

Pull requests welcome!
