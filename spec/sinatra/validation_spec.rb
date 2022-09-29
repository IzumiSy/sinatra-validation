require "spec_helper"

RSpec.describe Sinatra::Validation do
  it "has a version number" do
    expect(Sinatra::Validation::VERSION).not_to be nil
  end

  it 'returns 200 as POST' do
    post '/post', { name: "justine" }, as: :json
    expect(last_response.status).to eql(200)
  end

  it "returns 200 as GET" do
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

  it "raises an exception with `raise` option enabled" do
    get '/raise'
    expect(last_response.status).to eql(500)
    expect(last_response.body).to eql('invalid')
  end

  it "filter params with `filter_unpermitted_params`" do
    get '/filter?allowed=ok&filtered=nok'
    expect(last_response.status).to eql(200)
    expect(last_response.body).to eql("allowed=ok")
  end

  it "filter params and set them in result" do
    get '/result?allowed=ok&filtered=nok'
    expect(last_response.status).to eql(200)
    expect(last_response.body).to eql("allowed=ok")
  end

  it "returns 200 if the parameter meets the rule" do
    get '/rule/abcdef'
    expect(last_response.status).to eql(200)
    expect(last_response.body).to eql("ok")
  end

  it "returns 400 if the parameter does not meet the rule" do
    get '/rule/abc1234def'
    expect(last_response.status).to eql(400)
    expect(last_response.body).to eql("value Invalid param")
  end
end
