# coding: utf-8

class Admin::ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  layout :layout_by_resource
  
  def layout_by_resource
    if devise_controller? && controller_name == "sessions"
      'login'
    else
      "admin"
    end
  end
end