# app.rb
require 'sinatra'
require 'rubygems'
require 'sinatra/reloader' if development?
require 'erb'
require 'json'
require 'securerandom'
require 'openssl'
require './helpers/aes'
require './helpers/job_runner'
# custom
require './models/models.rb'
require './controllers/controllers.rb'


configure do
  set :port, 8080
  set :username, 'admin'
  set :password, 'sinatra'
  enable :sessions
  enable :logging
  enable :dump_errors
end
puts('http://localhost:8080')

