ENV['APP_ENV'] = 'test'

require_relative "../server"
require "rspec"
require "rack/test"

RSpec.describe "Api" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    context "get request" do
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
        it "returns the posts data for the requested id" do
            get "/api/posts/0"
            posts = {title: "First post", body: "content of first post"}
            expect(last_response).to be_ok
            expect(last_response.body).to eq(posts.to_json)
        end
    end

    context "post request" do
        it "should post successfully" do
            headers = { "CONTENT_TYPE" => "application/json" }
            post_body = {title: "Third post", body: "content of third post"}
            post "/api/posts", post_body.to_json, headers
            expect(last_response).to be_ok
            expect(last_response.body).to eq([post_body].to_json)
        end
    end

    context "put request" do
        it "updates one of the records" do
            headers = { "CONTENT_TYPE" => "application/json" }
            put_body = {title: "Updated first post", body: "the contents of the first post have been updated"}
            put "/api/posts/0", put_body.to_json, headers
            expect(last_response).to be_ok
            expect(last_response.body).to eq(put_body.to_json)
        end
    end

    context "delete request" do
        it "removes one of the records" do
            headers = { "CONTENT_TYPE" => "application/json" }
            delete_posts = {title: "Updated first post", body: "the contents of the first post have been updated"}
            delete "/api/posts/0"
            expect(last_response).to be_ok
            expect(last_response.body).to eq(delete_posts.to_json)
        end
    end

end