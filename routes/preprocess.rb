# encoding: utf-8
require 'less'

class MyApp < Sinatra::Application
  get '/styles/*.css' do |filename|
    if !File.exist?(File.join(settings.stylesDir, filename+'.less'))
      halt 404, {'Content-Type' => 'text/css'}, '/* File not found */'
    end
    begin
      less filename.to_sym, :views => settings.stylesDir
    rescue Less::Error => e
      halt 500, {'Content-Type' => 'text/css'}, "/* LESS ERROR: #{e.cause} */"
    end
  end

  get '/scripts/*.js' do |filename|
    path = File.join(settings.scriptsDir, filename+'.js')
    if !File.exist?(path)
      halt 404
    end
    send_file path
  end

  # for development built files
  get '/build/:filename' do
    send_file File.join('build', params[:filename])
  end

end