helpers do

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def current_user=(new_current_user)
    @current_user = new_current_user
    session[:email] = @current_user.email
    session[:user_id] = @current_user.id
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def logout
    session.clear
  end

end
