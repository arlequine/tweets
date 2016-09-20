
# GETS ============================================

get '/signin' do
	erb :signin
end

get '/sign_in' do
  # El método `request_token` es uno de los helpers
  # Esto lleva al usuario a una página de twitter donde sera atentificado con sus credenciales
  redirect request_token.authorize_url(:oauth_callback => "http://#{host_and_port}/auth")
  # Cuando el usuario otorga sus credenciales es redirigido a la callback_url 
  # Dentro de params twitter regresa un 'request_token' llamado 'oauth_verifier'
end

get '/auth' do
  # Volvemos a mandar a twitter el 'request_token' a cambio de un 'acces_token' 
  # Este 'acces_token' lo utilizaremos para futuras comunicaciones.   
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # Despues de utilizar el 'request token' ya podemos borrarlo, porque no vuelve a servir. 
  session.delete(:request_token)

  # Aquí es donde deberás crear la cuenta del usuario y guardar usando el 'acces_token' lo siguiente:
  # nombre, oauth_token y oauth_token_secret
  # No olvides crear su sesión 
end
  # Para el signout no olvides borrar el hash de session+


# Este debería ser un post 
get '/logout' do
	session.clear
  redirect ("/")
end

# POSTS ============================================

post '/signin' do
	email = params[:user][:email]
	password = params[:user][:password]
	@user = User.autenticate(email,password)

	if @user
  	session[:user_id] = @user.id
  	redirect ('/secret')
  else
  	@errors = "Invalid Email and Password"
  	erb :signin
  end

end

