# encoding: utf-8
require 'rails/generators'
require 'rails/generators/generated_attribute'

module Redde
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :controller_path, type: :string
      argument :model_name, type: :string, required: false

      attr_accessor :model_name, :controller_routing_path, :base_name,
                    :controller_class_path, :controller_file_path,
                    :controller_class_nesting, :controller_class_nesting_depth

      def initialize(args, *options)
        super(args, *options)
        initialize_views_variables
      end

      def copy_views
        generate_views
      end

      def generate_translations
        template 'ru.yml', "config/locales/#{resource_name}/ru.yml"
      end

      protected

      def initialize_views_variables
        @base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(controller_path)
        @controller_routing_path = @controller_file_path.gsub(/\//, '_')
        @model_name = @controller_class_nesting + "::#{@base_name.singularize.camelize}" unless @model_name
        @model_name = @model_name.camelize
      end

      def singular_controller_routing_path
        controller_routing_path.singularize
      end

      def plural_model_name
        model_name.pluralize
      end

      def resource_name
        model_name.demodulize.underscore
      end

      def plural_resource_name
        resource_name.pluralize
      end

      def capital_resource_name
        resource_name.capitalize
      end

      def index_header
        model_name.constantize.model_name.human(count: 'other')
      end

      def sort_priority(column_name)
        case column_name
        when 'position' then 1
        when 'visible' then 2
        when 'name' then 3
        when 'title' then 3
        else 5
        end
      end

      def columns
        model_name
          .constantize
          .columns
          .reject { |c| exclude_column?(c.name) }
          .sort { |a, b| sort_priority(a.name) <=> sort_priority(b.name) }
          .map { |c| convert_column(c) }
      end

      def default_name_for(column)
        case column.to_s
        when 'title' then 'Заголовок'
        when 'name' then 'Название'
        when 'slug' then 'URL'
        when 'position' then 'Позиция'
        when 'visible' then 'Отображать на сайте'
        when 'short_desc' then 'Аннотация'
        when 'comment' then 'Комментарий'
        when 'email' then 'E-mail'
        when 'image', 'src' then 'Изображение'
        when 'phone' then 'Телефон'
        when 'text', 'body', 'desc' then 'Описание'
        when 'parent_id' then 'Родительская категория'
        when 'company_id' then 'Компания'
        when 'city_id' then 'Город'
        when 'url' then 'Ссылка'
        when 'value' then 'Значение'
        when 'articul' then 'Артикул'
        when 'guid' then 'GUID'
        when 'tag_list' then 'Тэги'
        when 'category_id' then 'Категория'
        when 'message' then 'Сообщение'
        when 'product_id' then 'Товар'
        when 'price' then 'Цена'
        when 'stock', 'in_stock' then 'Наличие'
        when 'color', 'color_id' then 'Цвет'
        when 'size', 'size_id' then 'Размер'
        when 'parameter_id' then 'Параметр'
        else column.capitalize.to_s
        end
      end

      def excluded_column_names
        %w(id created_at updated_at)
      end

      def convert_column(column)
        ::Rails::Generators::GeneratedAttribute.new(column.name, column.type.to_s)
      end

      def exclude_column?(name)
        excluded_column_names.include?(name) || name.index('_id')
      end

      def column_names
        @model_name.constantize.column_names
      end

      def extract_modules(name)
        modules = name.include?('/') ? name.split('/') : name.split('::')
        name    = modules.pop
        path    = modules.map(&:underscore)
        file_path = (path + [name.underscore]).join('/')
        nesting = modules.map(&:camelize).join('::')
        [name, path, file_path, nesting, modules.size]
      end

      def generate_views
        views = {
          # "index.html.#{ext}" => contr_path('index'),
          "edit.html.#{ext}" => contr_path('edit')
        }
        selected_views = views
        options.engine == generate_erb(selected_views)
      end

      def contr_path(action)
        "app/views/admin/#{controller_file_path}/#{action}.html.#{ext}"
      end

      def generate_erb(views)
        views.each do |template_name, output_path|
          template template_name, output_path
        end
        generate_controller
      end

      def ext
        :haml
      end

      def generate_controller
        template 'controllers/controller.rb', "app/controllers/admin/#{plural_resource_name}_controller.rb"
      end
    end
  end
end
