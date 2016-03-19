# coding: utf-8
module Redde::AdminHelper

  def page_sidebar title = nil, &block
    content_for :page_sidebar do
      concat content_tag(:div, title, class: 'page-sidebar__title') if title
      concat capture(&block)
    end
  end

  def page_header(item = nil, &block)
    if block_given?
      content_for(:page_header, content_tag(:div, capture(&block), class: 'page-header'))
    elsif action_name == 'index'
      content_for(:page_header, content_tag(:div, render('admin/redde/page_header'), class: 'page-header'))
    else
      content_for(:page_header, content_tag(:div, render('admin/redde/page_header_edit', item: instance_variable_get("@#{record}")), class: 'page-header'))
    end
  end

  def redde_page(&block)
    item = instance_variable_get("@#{record}")

    capture do
      concat page_header
      concat redde_form_for([:admin, item]) { |f| capture(f, &block) }
      concat render('admin/redde_photos/photos', parent: item) if item.class.reflect_on_association(:photos)
    end
  end

  def redde_tree collection, opts = {}, &block
    content_tag :ol, class: 'sort-tree', 'data-sort-tree' => opts.to_json do
      redde_tree_list collection, &block
    end
  end

  def redde_tree_list collection, &block
    collection.each do |item|
      controls = content_tag(:div, link_to('Удал', url_for(action: :show, id: item), class: 'a_del sort-tree__btn', data: { confirm: 'Точно удалить?' }, method: 'delete'), class: 'sort-tree__controls')
      link = link_to title_for(item), url_for(action: :edit, id: item), class: 'sort-tree__link'
      html = content_tag :div, (block_given? ? capture(item, &block) : link).concat(controls), class: 'sort-tree__wrap', 'data-sort-tree-tolerance' => ""
      html << content_tag(:ol) do
        redde_tree_list(item.children.order(:position), &block)
      end if item.has_children?
      concat content_tag(:li, html, class: 'sort-tree__item', 'data-sort-tree-item' => "", id: "list_#{item.id}")
    end
  end

  def command_link(name, action, confirm = nil)
    options = { method: :put }
    options[:data] = { confirm: confirm } if confirm.present?
    link_to name, admin_system_command_path(action), options
  end

  def sidebar_link(title, path = [], additional_names = [])
    additional_names = [additional_names] unless additional_names.is_a?(Array)
    active_names = additional_names + [path.try(:last) || '']
    active_names.map!(&:to_s)
    classes = ['sidebar__link']
    classes << '_active' if active_names.include?(controller_name)
    link_to title, path, class: classes
  end

  def tsingular(model)
    model.model_name.human
  end

  def taccusative(model_name)
    t("activerecord.models.#{model_name}.acc")
  end

  def tplural(model)
    model.model_name.human(count: 'other')
  end
end
