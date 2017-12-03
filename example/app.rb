require 'sinatra'
require 'sinatra/base'
require 'sinatra/validation'

class Application < Sinatra::Base
  configure do
    register Sinatra::Validation
  end

  get '/basic' do
    validates do
      required('name').filled(:str?)
    end

    'ok'
  end

  get '/silent' do
    content_type :json

    result = validates silent: true do
      required('name').filled(:str?)
    end

    p result

    'ok'
  end

  get '/raise' do
    validates raise: true do
      required('name').filled(:str?)
    end

    'ok'
  end
end
