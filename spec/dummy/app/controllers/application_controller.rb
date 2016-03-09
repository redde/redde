class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  def layout_by_resource
    return 'login' if devise_controller? && controller_name == 'sessions'
    'application'
  end
end
