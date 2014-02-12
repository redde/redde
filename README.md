# Redde
[![Build Status](https://secure.travis-ci.org/redde/redde.png)](http://travis-ci.org/redde/redde)
[![Code Climate](https://codeclimate.com/github/redde/redde.png)](https://codeclimate.com/github/redde/redde)

Admin generator for redde projects

## Installation

Add this line to your application's Gemfile:

    gem 'redde'

And then execute:

    $ bundle

## Requirements

Layout requires 'devise' gem with generated user model. If You use another auth solution, feel free to modify partial with user info and logout link.

## Usage

To generate admin layout type:

    rails g redde:layout

To set admin login layout you need to modify application controller:

    layout :layout_by_resource

    def layout_by_resource
      if devise_controller? && controller_name == "sessions"
        'login'
      else
        "application"
      end
    end

To generate admin views and controller for a model, enter:
  
    rails g redde:scaffold ModelNames

Add `admin.scss` and `admin.js` to assets precompilation in config/production.rb:

    config.assets.precompile += %w( admin.js admin.css )
    
## Добавление фотографий

	rails g redde:photo
	
создаст scaffold для модели Photo с полиморфной связью

## Gemset dependenсies

Somehow, some dependencies are not initialized inside rails apps. If you get error about missing gems, add these gems to your Gemfile:

    gem 'autoprefixer-rails'
    gem 'jquery-ui-rails'
    gem 'haml-rails'
    gem 'russian'
    gem 'devise'
    
Its highly possible, that you will not have any problems with gems

## Autoprefixer note for development mode

Its neccessary to have joined asset files, change assets debug to false in `config/environments/development.rb`:

    config.assets.debug = false

## Localization's example

    ru:
      activerecord:
        models:
          product:
            one: Продукт
            acc: продукт (винительный падеж)
            other: Продукты
        attributes:
          product:
            name: Название
            descr: Описание

## WYSIWYG editor note

To use styles for the WYSIWYG editor, add its styles to precompile in `config/production.rb`:

    config.assets.precompile += %w( redactor/wym.css )
    
## Sortable

If you have field `position` of integer type in your model, generator will add special column as a hook for sort.
You should add POST `sort` action to you routes:

	resources :article_categories do
      post 'sort', on: :collection
    end

## Visible

If you have field `visible` of boolean type in your model, generator will add small eye column for toggling visiblity
