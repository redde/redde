#coding: utf-8

class Admin::ApplicationController < ActionController::Base
  layout 'admin'
  #before_filter :authenticate_user!
end