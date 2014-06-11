# encoding: utf-8
require 'less'

class BFAMFAPhD < Sinatra::Application
  get '/styles/*.css' do |filename|
    if !File.exist?(File.join(settings.stylesDir, filename+'.less'))
      halt 404
    end
    less filename.to_sym, :views => settings.stylesDir
  end

  get '/scripts/*.js' do |filename|
    path = File.join(settings.scriptsDir, filename+'.js')
    if !File.exist?(path)
      halt 404
    end
    send_file path
  end
end