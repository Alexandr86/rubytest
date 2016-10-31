require 'rspec'
require './app.rb'
require 'rack/test'

describe 'app behaviour' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end


it "should home page be loaded" do
  get '/'
  expect(last_response.status).to eq 200
  expect(last_request.path).to eq('/')
  expect(last_response.body).to include ("Home")
  expect(last_response.body).to include ("Login")
  expect(last_response.body).to include ("Logout")
  expect(last_response.body).to include ("Messages")
  expect(last_response.body).to include ("Create message")
end


  it "should messages be loaded" do
    get '/messages'
    expect(last_response.status).to eq 200
    expect(last_request.path).to eq('/messages')
  end

  it "should new be loaded" do
    get '/messages/new'
    expect(last_response.status).to eq 200
    expect(last_request.path).to eq('/messages/new')
    end

  it "should message be created" do
    post '/messages', params={:title => 'Test Message', :text => "Hi! I am testin message"}
    expect(last_response.ok?)
    expect(last_response.body.include?('Test Message'))
  end

  it "should login" do
    post '/login', params={:username => 'admin', :password => "sinatra"}
    expect(last_response.ok?)

  end
end

