require "spec_helper"

RSpec.describe Sinatra::Validation do
  it "has a version number" do
    expect(Sinatra::Validation::VERSION).not_to be nil
  end

  it "returns 200" do
    get '/basic?name=justine'
    expect(last_response.status).to eql(200)
  end

  it "returns 400 if the parameters needed" do
    get '/basic'
    expect(last_response.status).to eql(400)
  end

  it "returns 200 with `silent` option enabled" do
    get '/silent'
    expect(last_response.status).to eql(200)
  end

  # TODO here needs to check if Sinatra::Validation::InvalidParameterError is thrown or not
  it "return 500 with `raise` option enabled" do
    get '/raise'
    expect(last_response.status).to eql(500)
  end
end
