# coding: utf-8
module Redde::AdminHelper
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
    render('admin/redde_photos/photos', parent: parent)
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
