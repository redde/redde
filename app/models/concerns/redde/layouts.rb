module Redde::Layouts
  extend ActiveSupport::Concern

  included do
    layout :layout_by_resource
  end

  def layout_by_resource
    if devise_controller? && controller_name == 'sessions'
      'login'
    else
      'application'
    end
  end
end
