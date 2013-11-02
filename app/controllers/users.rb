get '/login' do
  if logged_in?
    redirect to('/')
  else
    erb :user_login
  end
end

post '/login' do
  email = params[:email]
  password = params[:password]

  if User.exists?(email)
    user = User.authenticate(email, password)
    if user
      send(:current_user=, user)
      redirect to('/')
    else
      @errors = {"password" => "incorrect"}
      erb :user_login
    end
  else
    @errors = {"email" => "does not exist, please register"}
    erb :user_login
  end
end

get '/register' do
  if logged_in?
    redirect to('/')
  else
    erb :user_registration
  end
end

post '/register' do
  @user = User.create(name: params[:name], email: params[:email], password: params[:password])
  if @user.valid?
    redirect to('/login')
  else
    @errors = @user.errors
    erb :user_registration
  end
end

post '/logout' do
  logout
  redirect to ('/login')
end