# coding: utf-8
module Redde::IndexHelper
  IGNORED_COLUMNS = %w(position created_at updated_at id)
  def title_for(item)
    item.send(title_symbol_for(item))
  end

  def title_symbol_for(item)
    return 'title' if column_names.include?('title')
    return 'name' if column_names.include?('name')
    model_name.columns.select { |i| i.type == :string }.first
  end

  class IndexBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Context

    attr_accessor :list, :params

    def initialize(list, params)
      @list = list
      @params = params
    end

    def empty( options = {} )
      content_tag(:th, "", class: ['list__head', options[:class]])
    end

    def thead insert
      content_tag :thead do
        content_tag(:tr, empty + visible + insert + empty(class: 'list__head_del') + empty)
      end
    end

    def visible
      empty(class: '_eye') if list.column_names.include?('visible')
    end

    class IndexHeadCellBuilder
      include ActionView::Helpers::TagHelper
      include ActionView::Context

      attr_accessor :list

      def initialize(list)
        @list = list
      end

      def cell field = nil, options = {}, &block
        if field.is_a?(Symbol) || field.is_a?(String)
          content_tag :th, list.human_attribute_name(field), class: ['list__head', options[:class]]
        elsif field.is_a?(Hash)
          content_tag :th, "", class: ['list__head', field[:class]]
        elsif field.nil?
          content_tag :th, "", class: 'list__head'
        end
      end
    end

    class IndexCellBuilder
      include ActionView::Helpers
      include ActionView::Context
      include ActionView::Helpers::UrlHelper
      include Rails.application.routes.url_helpers
      include Haml::Helpers

      attr_accessor :item, :builder

      def initialize(item, builder)
        @item = item
        @builder = builder
        init_haml_helpers
      end

      def self.content value
        case value.class.name
        when 'Time' then I18n.l(value, format: '%d %b %Y, %H:%M')
        when 'Date' then I18n.l(value, format: '%d %b %Y')
        else
          value
        end
      end

      def cell(field, options = {}, &block)
        # через content_tag ... do не работает
        if field.is_a?(Hash)
          content_tag :td, capture(&block), class: ['list__cell', field[:class]]
        else
          content_tag :td, if block_given? then capture(&block) else IndexCellBuilder.content(item.send(field)) end, class: ['list__cell', options[:class]]
        end
      end

      def empty(options = {})
        content_tag(:td, "", class: ['list__cell', options[:class]])
      end

      def handle
        return content_tag(:td, "", class: ['list__cell', '_handle'], 'data-sortable-handle' => "") if item.class.column_names.include?('position')
        empty
      end

      def visible
        content_tag :td, class: 'list__cell _eye' do
          link_to('', url_for(id: item, controller: builder.params[:controller], action: :update, item.class.model_name.param_key => { visible: !item.visible} ), class: ['list__eye', ('_disactive' if !item.visible)], data: { method: 'put' })
        end if item.class.column_names.include?('visible')
      end

      def del
        content_tag :td, class: 'list__cell list__cell_del' do
          link_to('', url_for(id: item, action: :destroy, controller: builder.params[:controller]), method: :delete, data: { confirm: 'Точно удалить?' }, class: 'list__del')
        end
      end
    end
  end

  def list_table(list, options = {}, &block)
    raise ArgumentError, "Missing block" unless block_given?
    builder = IndexBuilder.new(list, params)

    html = list.map do |item|
      cb = IndexBuilder::IndexCellBuilder.new(item, builder)
      content_tag(:tr, cb.handle + cb.visible + capture(cb, &block) + cb.del + cb.empty, 'data-href' => url_for(id: item, action: :edit), 'data-sortable-item' => "", id: "pos_#{item.id}")
    end.join.html_safe

    hb = IndexBuilder::IndexHeadCellBuilder.new(list)
    content_tag :table, class: ['list', options[:class]], style: options[:style], "data-sortable" => { handle: "[data-sortable-handle]" }.to_json do
      concat builder.thead( capture(hb, &block) )
      concat html
    end
  end

  def collection
    controller_name
  end

  def record
    controller_name.singularize
  end

  def model_name
    record.camelize.constantize
  end

  def column_names
    model_name
      .column_names
      .reject { |c| excluded_column_names.include?(c) }
      .sort { |a, b| sort_priority(a) <=> sort_priority(b) }
  end

  def index_columns
    return column_names unless defined?(model_name::INDEX_COLUMNS)
    return model_name::INDEX_COLUMNS if model_name::INDEX_COLUMNS.is_a?(Array)
    model_name::INDEX_COLUMNS.keys
  end

  def form_column_names
    return column_names.select { |i| !IGNORED_COLUMNS.include?(i) } unless defined?(model_name::FORM_COLUMNS)
    return model_name::FORM_COLUMNS if defined?(model_name::FORM_COLUMNS)
    res = model_name::INDEX_COLUMNS
    res.keys if model_name::INDEX_COLUMNS.is_a?(Hash)
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

  def excluded_column_names
    %w(id created_at updated_at)
  end

  def list_table_options
    {}.tap do |options|
      if column_names.include? 'position'
        options['class'] = 'sortable'
        options['data-sortable'] = ""
      end
    end
  end

  def sort_table_options(item)
    {}.tap do |options|
      if column_names.include?('position')
        options[:id] = "pos_#{item.id}"
        options['data-sortable-item'] = ""
      end
    end
  end

  def show_tree(c)
    link = link_to c.name, [:edit, :admin, c]
    edit = link_to 'Удал', [:admin, c], data: { confirm: 'Точно удалить?' },
                                        method: :delete, class: 'del'
    html = content_tag(:div, link + content_tag(:p, edit))
    if c.children.any?
      html << content_tag(:ol) do
        raw c.children.map { |ch| show_tree(ch) }.join('')
      end
    end
    content_tag :li, raw(html), id: "list_#{c.id}"
  end

  def ancestry_tree(obj_class, symbol)
    ancestry_options(obj_class.unscoped.arrange(order: :position), symbol) { |i| "#{'--' * i.depth} #{i.send(symbol)}" }
  end

  def ancestry_options(items, symbol = :name, &block)
    return ancestry_options(items, symbol) { |i| "#{'-' * i.depth} #{i.send(symbol)}" } unless block_given?

    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      result += ancestry_options(sub_items, symbol) { |i| "#{'---' * i.depth} #{i.send(symbol)}" }
    end
    result
  end

  def render_item_column(item, column)
    value = index_value_for(item, column).try(:html_safe)
    return 'Не задано' unless value.present?
    case value.class.name
    when 'Time' then l(value, format: '%d %b %Y, %H:%M')
    when 'Date' then l(value, format: '%d %b %Y')
    else
      value
    end
  end

  def index_value_for(item, column)
    return model_name::INDEX_COLUMNS[column.to_sym].call(item) if defined?(model_name::INDEX_COLUMNS) && model_name::INDEX_COLUMNS.is_a?(Hash) && model_name::INDEX_COLUMNS[column.to_sym].present?
    item.send(column)
  end
end
