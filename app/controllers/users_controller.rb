
# GETS ============================================

get '/signup' do
	erb :signup
end


# POSTS ============================================

post '/signup' do
	@user = User.new(params[:user])

	if @user.save
		session[:user_id] = @user.id
		erb :authenticate
	else
		@errors = @user.errors
		erb :signup
	end
end
