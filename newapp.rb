require 'sinatra'

class MyApp < Sinatra::Application

  get '/hello' do
    'Hello world!'
  end

end