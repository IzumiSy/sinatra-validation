require 'sinatra'
require 'sinatra/base'
require 'sinatra/validation'

class Application < Sinatra::Base
  configure do
    register Sinatra::Validation
  end

  get '/basic' do
    validates do
      required("name").filled(:str?)
      required("age").filled(:str?)
    end

    body "OK basic"
  end

  get '/silent' do
    content_type :json

    validates silent: true do
      required("name").filled(:str?)
      required("age").filled(:str?)
    end

    body "OK silent"
  end
end
