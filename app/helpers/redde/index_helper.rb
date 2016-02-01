# coding: utf-8
module Redde::IndexHelper
  IGNORED_COLUMNS = %w(ancestry position created_at updated_at id)
  def title_for(item)
    return item.title if column_names.include?('title')
    return item.name if column_names.include?('name')
    model_name.columns.select { |i| i.type == :string }.first
  end

  def list_table res_collection, &block
    render layout: 'admin/redde/list', locals: { res_collection: res_collection } do
      res_collection.each do |item|
        concat list_table_row( item, &block )
      end
    end
  end

  def list_table_row item, &block
    render layout: 'admin/redde/row', locals: { item: item } do
      column_names.each do |column|
        concat list_table_cell(item, column, &block)
      end
    end
  end

  def list_table_cell item, column, &block
    case column
    when 'position'
      content_tag(:td, "", class: 'list__cell _handle', 'data-sortable-handle' => "")
    when 'visible'
      content_tag(:td, link_to('', url_for(id: item, action: :update, record => { visible: !item.visible} ), class: ['list__eye', ('_disactive' if !item.visible)], data: { method: 'put' }), class: 'list__cell _eye')
    when 'title', 'name'
      content_tag(:td, link_to(item.send(column), url_for(id: item, action: :edit)), class: 'list__cell')
    else
      if block_given?
        capture(item, column, &block)
      else
        content_tag :td, item.send(column), class: 'list__cell'
      end
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

  def form_column_names
    column_names.select { |i| !IGNORED_COLUMNS.include?(i) }
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
end
