# encoding: utf-8

class MyApp < Sinatra::Application

  get '/*' do |page|
    path = File.join(settings.views, page+'.erb')
    pass unless File.exist?(path)

    @page = page.to_sym
    erb @page
  end
end