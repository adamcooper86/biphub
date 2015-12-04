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

  def authorize p_id = params[:id]
    if current_user
      unless current_user.id.to_s == p_id
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

  def authorize_coordinator school_id
    if current_user.is_a?(Coordinator) && current_user.school.id.to_s == school_id
      true
    else
      session[:user_id] = nil
      redirect_to '/login'
      false
    end
  end
end
