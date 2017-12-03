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

    body 'OK basic'
  end

  get '/json' do
    content_type :json

    validates do
      required('name').filled(:str?)
    end

    body 'OK json'
  end

  get '/silent' do
    result = validates silent: true do
      required('name').filled(:str?)
    end

    p result

    body 'OK silent'
  end

  get '/raise' do
    validates raise: true do
      required('name').filled(:str?)
    end

    body 'OK raise'
  end
end
