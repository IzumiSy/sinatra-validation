require 'rspec'
require 'rack/test'
require 'bundler/setup'
require 'sinatra/validation'

ENV['RACK_ENV'] = 'test'

require_relative '../example/app'

RSpec.configure do |config|
  include Rack::Test::Methods

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def app
    Application.new
  end
end
