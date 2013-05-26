class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user_id, :current_user

  protected
  def current_user_id
  	session[:user_id]
  end

  protected
  def current_user
  	User.find_by_id(session[:user_id])
  end

end
