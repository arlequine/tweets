before '/secret' do 
	unless session[:user_id]
	  session[:errors] = "No tienes una sesión por favor inicia sesión"
		redirect ("/")
	end
	@user = User.find(session[:user_id])
end 

# GETS ============================================================================================

get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index
end

get '/secret' do
  #@clients = CLIENT.friends('codeacamp').users.first
  #@clients = CLIENT.friends
  erb :search
end

get '/search' do 

	erb :secret
end

# POSTS ===========================================================================================

post '/search_tweet' do
	@client = params[:tweet]
	twitter = TwitterUser.find_by(twitter_handle: @client)
	if  twitter
		@clients = Tweet.where(twitter_user_id: twitter.id)
	else
	  twitter_user = TwitterUser.create(twitter_handle: @client)
    @clients = CLIENT.search(@client)
	  @clients.each do |tweet|
	    Tweet.create(tweet: tweet.text, twitter_user_id: twitter_user.id)
	  end
  end
  erb :secret
end

post '/tweet' do
  @tweet = CLIENT.update(params[:tweet_text])
  erb :_tweet, layout: false
end


