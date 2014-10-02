# encoding: utf-8

class BFAMFAPhD < Sinatra::Application

  get '/*' do |page|
    puts page
    erb page.to_sym
  end
end