require 'sinatra'

class BFAMFAPhD < Sinatra::Application

  get '/hello' do
    'Hello world!'
  end

end