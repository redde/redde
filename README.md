# Redde

Redde admin generator

## Installation

Add this line to your application's Gemfile:

    gem 'redde', :group => :development

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

To generate admin views and controller for model type:
  
    rails g redde:scaffold ModelNames

Add to your config/production.rb these files: admin.scss and admin.js

    config.assets.precompile += %w( admin.js admin.css )

## Gemset dependenсies

    gem 'compass-rails'
    gem 'jquery-ui-rails'
    gem 'haml-rails'
    gem 'russian'
    gem 'devise'

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

## WYSIWYG redactor
Add to your config/production.rb

    config.assets.precompile += %w( redactor/wym.css )
    
## Options
If you have these fields in your model:

* `visible:boolean` for toggle option
* `position:integer` for sortable option

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
