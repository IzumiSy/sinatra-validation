require 'sinatra'
require 'sinatra/base'
require 'sinatra/validation'

class Application < Sinatra::Base
  configure do
    register Sinatra::Validation
  end

  before do
    content_type :json
  end

  get '/user' do
    permitted_params = validates do
      required("name").filled(:str?)
    end

    body "name: #{permitted_params[:name]}"
  end
end
