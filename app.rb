# encoding: utf-8
require 'sinatra'
require 'erb'
require 'pg'
require 'pp'

class BFAMFAPhD < Sinatra::Application

  # set :database, ENV['DATABASE_URL'] || 'postgres://localhost/bfamfaphd'

  configure do
    set :stylesDir, File.join(settings.root, 'styles')
    set :scriptsDir, File.join(settings.root, 'scripts')

  end

  configure :production do
    # db_parts = ENV['DATABASE_URL'].split(/\/|:|@/)
    # username = db_parts[3]
    # password = db_parts[4]
    # host = db_parts[5]
    # port = db_parts[6]
    # db = db_parts[7]
    # set :db, PG::Connection.new(:host =>  host, :dbname => db, :user => username, :password => password, :port => port)

   # require 'newrelic_rpm'
  end

  configure :development do
    # set :db, PG::Connection.new({:host => 'localhost', :port => 5432, :user => (`whoami`).strip, :dbname => 'bfamfaphd'})

    scriptsManifest = IO.readlines('scripts.manifest')
    scriptsManifest.map! {|s| s.chomp!}
    set :scriptsManifest, scriptsManifest
  end

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end

end

# require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'