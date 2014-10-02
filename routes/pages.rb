# encoding: utf-8

class MyApp < Sinatra::Application

  get '/*' do |page|
    puts page
    erb page.to_sym
  end
end