# Redde
[![Build Status](https://secure.travis-ci.org/redde/redde.png)](http://travis-ci.org/redde/redde)
[![Code Climate](https://codeclimate.com/github/redde/redde.png)](https://codeclimate.com/github/redde/redde)

Admin generator for redde projects

## Installation

* Add this line to your application's Gemfile and run `bundle` command:

```
  gem 'redde'
```

* For the first time installation run

```
rails g redde:layout
```

This command will generate basic structure for your admin interface.

* Mound engine in your routes.rb

```
devise_for :managers, controllers: { registrations: 'managers/registrations' } if defined?(Devise)
mount Redde::Engine, at: '/redde'
```

It will disable Manager model registration with `devise` and mount engine.

* Include layout concern in your ApplicationController

```
class ApplicationController < ActionController::Base
  include Redde::Layouts
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
```

* Install and run migrations

```
rake redde:install:migrations
rake db:migrate
```

* Include assets in your `admin.js` and `admin.css`

`admin.js`

```
//= require redde-admin
//= require redde-admin/fileapi
```

`admin.css`

```
 *= require redde-admin
```

### Scaffold

To generate admin views and controller for a model, enter:

```
rails g redde:scaffold ModelNames
```
It will generate empty controller with all needed stuff. If you want to customize it - feel free to override views and controller actions.

If you have `position` field of integer type in your model, generator will add special column as a hook for sort.
You should add POST `sort` action to you routes:

```
resources :article_categories do
  post 'sort', on: :collection
end
```
If you have `visible` field of boolean type in your model, generator will add small eye column for toggling visiblity

### UrlGenerator

`Redde::UrlGenerator` - is a small lib to convert title and id to combine url, used in `to_param` method.

Usage example:

    generator = Redde::UrlGenerator.new(1, 'тестовый заголовок $%##@$@#$')
    generator.url
    => '1-testovyy-zagolovok'

### Sluggable

`Sluggable` is used to include into model with permanent slugs (similar to permalink).

Your ActiveRecord model should have `slug` field and title field.

You can set title field by setting `TITLE_FIELD` to symbol of method. This method will be used to generate `slug`.
If `TITLE_FIELD` constant is not set, `:title` symbol will be used insted.

Usage example:

Book should have title and slug fields.

    class Book < ActiveRecord::Base
      TITLE_SYMBOL = :name
      include Redde::Sluggable
      validates :name, presence: true
    end

    b = Book.new(name: 'Тестовая книга')
    b.save
    b.slug
    => 'testovaya-kniga'

    b.to_param
    => '1-testovaya-kniga'

## Photos

You can attach photos to any ActiveRecord model by including

```
include Redde::WithPhoto
```

## Localization

By default, views in admin interface use I18n for field names and titles.
Example:

```
ru:
  activerecord:
    models:
      article:
        acc: статью
        many: Статьи
        one: Статья
        other: Статьи
      article_category:
        acc: категорию
        many: Категории
        one: Категория
        other: Категории

    attributes:
      article:
        title: Заголовок
        slug: URL
        body: Текст
      article_category:
        title: Заголовок
        position: Позиция
        visible: Отображать на сайте
```
