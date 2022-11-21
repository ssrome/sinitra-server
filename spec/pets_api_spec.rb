ENV['APP_ENV'] = 'test'

require "../server"
require "rspec"
require "rack/test"

RSpec.describe "Api" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    context "pets" do
        it "returns an ok response" do
            get "/api/pets-count"
            expect(last_response.status).to eq(200)
        end 
        it "returns the amount of pets" do 
            get "/api/pets-count"
            expect(last_response.body).to eq("3")
        end
        it "returns an ok response for pet owners" do
            get "/api/pets/owners"
            expect(last_response.status).to eq(200)
        end
        it "returns the pet owners" do
            get "/api/pets/owners"
            pets_and_owners = [["Sasha", "Lucy"], ["Dory", "Barbora"], ["Virgil", "Dom"]]
            expect(last_response.body).to eq(pets_and_owners.to_json)
        end

        it "adds a pet with an known owner" do
            headers = { "CONTENT_TYPE" => "application/json" }
            put_body = {name: "Dante", type: "cat", gender: "boy", neutered: "yes", owner: "Dom"}
            put "/api/pet", put_body.to_json, headers
            expect(last_response.status).to eq(200)
            expect(last_response.body).to eq(put_body.to_json)
        end

        it "deletes a pets record" do
            headers = { "CONTENT_TYPE" => "application/json" }
            delete_body = {name: "Dante", type: "cat", gender: "boy", neutered: "yes", owner: "Dom"}
            delete "/api/pet", delete_body.to_json, headers
            expect(last_response.status).to eq(200)
            expect(last_response.body).to eq(delete_body.to_json)
        end

        it "adds a pets record with an unknown owner" do
            headers = { "CONTENT_TYPE" => "application/json" }
            put_body = {name: "Roger", type: "cat", gender: "male", neutered: "yes", owner: "Doe"}
            put "/api/pet", put_body.to_json, headers
            expect(last_response.status).to eq(200)
            expect(last_response.body).to eq(put_body.to_json)
        end

        it "deletes a pets record" do
            headers = { "CONTENT_TYPE" => "application/json" }
            delete_body = {name: "Roger", type: "cat", gender: "male", neutered: "yes", owner: "Doe"}
            delete "/api/pet", delete_body.to_json, headers
            expect(last_response.status).to eq(200)
            expect(last_response.body).to eq(delete_body.to_json)
        end

        it "deletes an owner record" do
            headers = { "CONTENT_TYPE" => "application/json" }
            delete_body = {owner: "Doe"}
            delete "/api/owner", delete_body.to_json, headers
            expect(last_response.status).to eq(200)
            expect(last_response.body).to eq(delete_body.to_json)
        end
    end
end