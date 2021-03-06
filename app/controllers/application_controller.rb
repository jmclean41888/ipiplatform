class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :store_location

  def redirect_if_not_signed_in
    redirect_to new_session_path, notice: 'Please sign in!' and return if current_user.nil?
  end

  def redirect_if_unauthorized
    redirect_to root_path, notice: 'Not authorized!' and return unless current_user.present? && current_user.is_admin?
  end

  def store_location
    if (request.fullpath != "/users/new" &&
      request.fullpath != "/sessions/new" &&
      request.fullpath != "/sessions" &&
      !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
