# coding: utf-8
module Redde::AdminHelper

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
      concat photoable(item)
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

  def photoable(parent)
    render('admin/redde_photos/photos', parent: parent) if parent.class.reflect_on_association(:photos)
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
