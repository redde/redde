# coding: utf-8
module Redde::IndexHelper
  IGNORED_COLUMNS = %w(ancestry position created_at updated_at id)
  def title_for(item)
    return item.title if column_names.include?('title')
    return item.name if column_names.include?('name')
    model_name.columns.select { |i| i.type == :string }.first
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
        options['data-sortable'] = true
      end
    end
  end

  def sort_table_options(item)
    {}.tap do |options|
      options[:id] = "pos_#{item.id}" if column_names.include?('position')
    end
  end
end
