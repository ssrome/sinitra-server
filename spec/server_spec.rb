ENV['APP_ENV'] = 'test'

require_relative "../server"
require "rspec"
require "rack/test"

RSpec.describe "App" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    describe "multiverse" do
        it "returns an ok status" do
            get "/"
            expect(last_response).to be_ok
        end
        it "returns the genric greeting when no name is sent" do
            get "/"
            expect(last_response.body).to include("Hello and welcome")
        end
        it "returns a greeting when a name is sent" do
            get "/Doe"
            expect(last_response.body).to include("Hello Doe and welcome")
        end
        it "returns a title heading" do
            get "/"
            expect(last_response.body).to include("h1")
        end
        it "returns page name on the page " do
            get "/"
            expect(last_response.body).to include("multiverse")
        end
        it "returns an image" do
            get "/"
            expect(last_response.body).to include("img")
        end
        it "returns information about page" do
            get "/"
            expect(last_response.body).to include("grandma")
        end
    end
end 
