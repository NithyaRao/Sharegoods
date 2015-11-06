class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :check_headers
 # before_filter :auth_user


  rescue_from Pundit::NotAuthorizedError do |exception|
     redirect_to root_url, alert: exception.message
  end
 
  def after_sign_in_path_for(resource)
     new_group_path
  end

  def after_sign_out_path_for(resource)
     root_path
  end

  def check_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end 

  def auth_user
    redirect_to root_path unless user_signed_in?
  end

  protected
 
  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :name
  end

end
