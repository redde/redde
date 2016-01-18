# coding: utf-8
module Redde::IndexHelper
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
    model_name.column_names.reject { |c| excluded_column_names.include?(c) }
      .sort { |a, b| sort_priority(a) <=> sort_priority(b) }
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

  def table_options
    {}.tap do |options|
      if column_names.include? 'position'
        options['class'] = 'sortable'
        options['data-sortable'] = true
      end
    end
  end
end
