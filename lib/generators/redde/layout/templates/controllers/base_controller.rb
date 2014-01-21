#coding: utf-8

class Admin::BaseController < ActionController::Base
  layout 'admin'
  before_filter :authenticate_manager!

  def welcome
  end
  
end