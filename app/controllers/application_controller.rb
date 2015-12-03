class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session.delete(:user_id)
      nil
  end
  helper_method :current_user

  def authorize
    if current_user
      unless current_user.id.to_s === params[:id]
        session[:user_id] = nil
        redirect_to '/login'
      end
    else
      redirect_to '/login'
    end
  end

  def authorize_admin
    unless current_user.is_a? Admin
      session[:user_id] = nil
      redirect_to '/'
    end
  end
end
