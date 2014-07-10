class Admin::BaseController < ActionController::Base
  layout 'admin'
  before_filter :authenticate_manager!
  include AdminHelper

  def welcome
  end

  private

  def redirect_or_edit(obj, saved, notice = nil)
    if saved
      redirect_to url_for_obj(obj), notice: notice_for(obj, notice)
    else
      render 'edit'
    end
  end

  def notice_for(obj, notice = nil)
    notice ||= 'сохранен'
    "#{obj.class.model_name.human} #{notice}."
  end

  def url_for_obj(obj)
    return [:edit, :admin, obj] if params[:commit] == 'Применить'
    [:admin, obj.class.model_name.plural.to_sym]
  end
end
