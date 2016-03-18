class Admin::BaseController < ActionController::Base
  layout 'admin'
  before_action :authenticate_manager!
  include Redde::AdminHelper
  include Redde::IndexHelper

  def welcome
  end

  def index
    instance_variable_set("@#{collection}", scope)
    return render 'tree' if column_names.include?('ancestry')
  end

  def new
    instance_variable_set("@#{record}", model_name.new)
    render 'edit'
  end

  def create
    instance_variable_set("@#{record}", model_name.new(params[record.to_sym].permit!))
    redirect_or_edit(instance_variable_get("@#{record}"), instance_variable_get("@#{record}").save)
  end

  def edit
    instance_variable_set("@#{record}", model_name.find(params[:id]))
  end

  def update
    instance_variable_set("@#{record}", model_name.find(params[:id]))
    redirect_or_edit(instance_variable_get("@#{record}"), instance_variable_get("@#{record}").update(params[record.to_sym].permit!))
  end

  def destroy
    instance_variable_set("@#{record}", model_name.find(params[:id]))
    instance_variable_get("@#{record}").destroy
    redirect_to send("admin_#{collection}_path"), notice: "#{model_name.model_name.human} удалена."
  end

  def sort
    if column_names.include?('ancestry')
      model_name.sort(params[:list])
    else
      params[:pos].each_with_index do |id, idx|
        p = model_name.find(id)
        p.update(position: idx)
      end
    end
    render nothing: true
  end

  private

  def scope
    return model_name.roots.order(:position) if column_names.include?('ancestry')
    scope = model_name
    scope = scope.order('position') if column_names.include?('position')
    scope.all.page(params[:page])
  end

  def redirect_or_edit(obj, saved, notice = nil, custom_url = nil)
    return render 'edit' unless saved
    yield if block_given?
    redirect_to url_for_obj(obj, custom_url), notice: notice_for(obj, notice)
  end

  def notice_for(obj, notice = nil)
    notice ||= default_notice
    "#{obj.class.model_name.human} #{notice}."
  end

  def default_notice
    'сохранена'
  end

  def url_for_obj(obj, custom_url = nil)
    return custom_url if custom_url.present?
    return [:edit, :admin, obj] if params[:commit] == 'Применить'
    [:admin, obj.class]
  end
end
