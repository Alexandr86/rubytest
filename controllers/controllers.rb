
get '/' do
  erb :index
end



get '/messages' do
  @messages = Messages.all
  if session[:admin]
    @messages.each do |item|
      item[:text] = AESCrypt.decrypt(item[:text], OpenSSL::Digest::SHA256.new("#ruby#").digest, nil, "AES-256-CBC")
    end
    end
  erb :messages
end


get '/messages/new' do
  @messages = Messages.new
  erb :message_new
end

post '/messages' do
  data = params[:message]
  data[:uuid] = SecureRandom.hex(10)
  data[:text] = AESCrypt.encrypt( data[:text], OpenSSL::Digest::SHA256.new("#ruby#").digest, nil, "AES-256-CBC")
  data[:created_at] = DateTime.now
  if data[:checkbox]
     data.delete("checkbox")
     data[:deleted_at] = DateTime.now #+ (1.0/24)
  end
  @message = Messages.create(data)
  redirect to ('/messages')
end


delete '/message/delete'  do
    @uuid= request.body.read
    Messages.first(:uuid => @uuid).destroy
    redirect to ('/messages')
end


not_found do
  status 404
  erb :not_found
end

get '/login' do
  erb :login
end

post '/login' do
  credentials = params[:credentials]
  if credentials[:username] == settings.username && credentials[:password] == settings.password
    session[:admin] = true
    redirect to('/messages')
  else
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end
