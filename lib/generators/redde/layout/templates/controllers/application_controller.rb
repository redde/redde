#coding: utf-8

class Admin::ApplicationController < ActiveController::Base
  layout 'admin'
  #before_filter :authenticate_user!
end