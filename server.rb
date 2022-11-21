require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'dotenv/load'

connection = PG::Connection.open(
    :host => ENV['PGHOST'],
    :port => ENV['PORT'] ? ENV['PORT'] : 5432,
    :dbname => ENV['POSTGRES_DB'],
    :user => ENV['POSTGRES_USER'],
    :password => ENV['PASSWORD'])

get "/:name?" do |name|
    if (name)
        erb :index, :locals => {:name=>" #{name}"}
    else
        erb :index, :locals => {:name=>""}
    end
end

# https://www.boredapi.com/api/activity


def getBody(req)
    req.body.rewind
    return JSON.parse(req.body.read)
end

posts = [{title: "First post", body: "content of first post"}, {title: "second post", body: "content of second post"}]

get "/api/posts" do
    return posts.to_json
end

get "/api/posts/:id" do
    id = params["id"].to_i
    return posts[id].to_json
end

post "/api/posts" do
    body = getBody(request)

    new_post = [{title: body["title"], body: body["body"]}]

    posts.push(new_post)

    return new_post.to_json
end

put "/api/posts/:id" do
    id = params["id"].to_i
    body = getBody(request)

    posts[id][:title] = body["title"]
    posts[id][:body] = body["body"]

    return posts[id].to_json
end

delete "/api/posts/:id" do
    id = params["id"].to_i

    post = posts.delete_at(id)

    return post.to_json
end

get "/api/pets-count" do
    response = connection.exec_params("select count(*) from pets").values[0]
    response
end

get "/api/pets/owners" do
    response = connection.exec_params("select pets.name, owners.owner from pets join owners on owners.id = pets.owner_id").values.to_json
    response
end

put "/api/pet" do
    body = getBody(request)
    owner_found = connection.exec_params("SELECT id FROM owners WHERE owner='#{body["owner"]}'").values
    
    if owner_found.length == 0
        connection.exec_params("INSERT INTO owners (owner) VALUES('#{body["owner"]}')")
        new_owner = connection.exec_params("SELECT id FROM owners WHERE owner='#{body["owner"]}'").values
        owner_id = new_owner[0][0]
    else
        owner_id = owner_found[0][0]
    end

    response = connection.exec_params("INSERT INTO pets (name, type, gender, neutered, owner_id) VALUES ('#{body["name"]}', '#{body["type"]}', '#{body["gender"]}', '#{body["neutered"]}', '#{owner_id}')")
    return body.to_json
end

delete "/api/pet" do
    body = getBody(request)
    response = connection.exec_params("DELETE FROM pets WHERE name='#{body["name"]}'")
    return body.to_json
end

delete "/api/owner" do
    body = getBody(request)
    response = connection.exec_params("DELETE FROM owners WHERE owner='#{body["owner"]}'")
    return body.to_json
end
