require 'rack/contrib'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/validation'
require 'pry' if development? or test?

class Application < Sinatra::Base
  configure do
    register Sinatra::Validation

    use Rack::JSONBodyParser
  end

  post '/post' do
    content_type :json

    validates do
      params do
        required(:name).filled(:str?)
      end
    end

    'ok'
  end

  get '/basic' do
    validates do
      params do
        required(:name).filled(:str?)
      end
    end

    'ok'
  end

  get '/silent' do
    content_type :json

    validates silent: true do
      params do
        required(:name).filled(:str?)
      end
    end

    'ok'
  end

  get '/raise' do
    begin
      validates raise: true do
        params do
          required(:name).filled(:str?)
        end
      end

      'ok'
    rescue Sinatra::Validation::InvalidParameterError => e
      halt 500, 'invalid'
    end
  end

  get '/filter' do
    validates filter_unpermitted_params: true do
      params do
        optional(:allowed).filled(:str?)
      end
    end
    params.map{|k, v| "#{k}=#{v}"}.join(' ')
  end

  get '/result' do
    result = validates do
      params do
        optional(:allowed).filled(:str?)
      end
    end
    result.params.map{|k, v| "#{k}=#{v}"}.join(' ')
  end
end
