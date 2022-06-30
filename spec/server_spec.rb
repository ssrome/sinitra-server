ENV['APP_ENV'] = 'test'

require_relative "../server"
require "rspec"
require "rack/test"

RSpec.describe "server" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    describe "greetings" do
        it "returns an ok status" do
            get "/"
            expect(last_response).to be_ok
        end
        it "returns the genric greeting when no name is sent" do
            get "/"
            expect(last_response.body).to eq("Hello, it's nice to meet you!")
        end
        it "returns a greeting when a name is sent" do
            get "/Roger"
            expect(last_response.body).to eq("Hello Roger! Nice to meet you!")
        end
    end

    describe "multiverse" do
        it "returns an ok status" do
            get "/page/multiverse"
            expect(last_response).to be_ok
        end
        it "returns a title heading" do
            get "/page/multiverse"
            expect(last_response.body).to include("h1")
        end
        it "returns page name on the page " do
            get "/page/multiverse"
            expect(last_response.body).to include("multiverse")
        end
        it "returns an image" do
            get "/page/multiverse"
            expect(last_response.body).to include("img")
        end
        it "returns a greeting" do
            get "/page/multiverse"
            expect(last_response.body).to include("welcome")
        end
        it "returns information about page" do
            get "/page/multiverse"
            expect(last_response.body).to include("grandma")
        end
    end
end 
