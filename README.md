# Redde

Redde admin generator

## Installation

Add this line to your application's Gemfile:

    gem 'redde'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redde

## Requirements

Layout requires 'devise' gem with generated user model. If You use another auth solution, feel free to modify partial with user info and logout link.

## Usage

To generate admin layout type:

    rails g redde:layout

For set admin login layout you need add to application controller:

    layout :layout_by_resource

    def layout_by_resource
      if devise_controller? && controller_name == "sessions"
        'login'
      else
        "application"
      end
    end

To generate admin views and controller for model type:
  
    rails g redde:scaffold ModelName

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
