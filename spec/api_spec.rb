ENV['APP_ENV'] = 'test'

require_relative "../server"
require "rspec"
require "rack/test"

RSpec.describe "App" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    describe "API" do
        it "returns an ok status" do
            get "/api/posts"
            expect(last_response).to be_ok
        end
        # it "returns " do
        #     get "/api/posts"
        #     posts = [{title: "First post", body: "content of first post"}]
        #     expect(last_response.body.to_json).to eq(posts)
        # end
    end
end