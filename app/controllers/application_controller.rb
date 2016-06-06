class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_user

  private

  def authenticate_user!
    unless @current_user
      flash[:error] = "Accès interdit"
      return redirect_to '/users/login'
    end
  end

  def set_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end
