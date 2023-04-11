require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/names' do
    names = params[:name_list]

    return names
  end

  get '/hello' do
    @name = params[:name]

    return erb(:index)
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]

    "Thanks #{name}, you sent this message: #{message}"
  end

  post '/sort_names' do
    names = params[:names]

    temp_names = names.split(",")
    sorted_names = temp_names.sort()

    return sorted_names.join(",")
  end
end
