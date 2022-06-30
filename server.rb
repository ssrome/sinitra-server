require 'sinatra'
require 'sinatra/reloader' if development?

get '/:name?' do |name|
    if(name)
        "Hello #{name}! Nice to meet you!"
    else
    "Hello, it's nice to meet you!"
    end
end