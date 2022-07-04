require 'sinatra'
require 'sinatra/reloader' if development?

get "/:name?" do |name|
    if (name)
        erb :index, :locals => {:name=>" #{name}"}
    else
        erb :index, :locals => {:name=>""}
    end
end