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

  it "return 500 with `raise` option enabled" do
    expect {
      get '/raise'
    }.to raise_error(Sinatra::Validation::InvalidParameterError)
  end
end
