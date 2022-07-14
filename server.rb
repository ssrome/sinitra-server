require 'sinatra'
require 'sinatra/reloader' if development?

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