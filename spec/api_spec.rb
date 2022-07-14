ENV['APP_ENV'] = 'test'

require_relative "../server"
require "rspec"
require "rack/test"

RSpec.describe "Api" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end
    
    it "returns an ok status" do
        get "/api/posts"
        expect(last_response).to be_ok
    end
    it "returns the posts data" do
        get "/api/posts"
        posts = [{title: "First post", body: "content of first post"}, {title: "second post", body: "content of second post"}]
        # posts = [{title: "First post", body: "content of first post"}]
        expect(last_response.body).to eq(posts.to_json)
    end
    
end