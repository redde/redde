# coding: utf-8

class ArticlesController < ApplicationController

  def index
  end

  def show
    @article = Article.find(params[:id])
  end
  
end