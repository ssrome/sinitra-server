ENV['APP_ENV'] = 'test'

require_relative "../server"
require "rspec"
require "rack/test"

RSpec.describe "Api" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    
end