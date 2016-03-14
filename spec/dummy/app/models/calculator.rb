class Calculator < ActiveRecord::Base
  INDEX_COLUMNS = {
    name: '',
    hop: ->(item) { ActionController::Base.helpers.link_to("На сайт (#{2 * 2})", Rails.application.routes.url_helpers.root_path(id: item.id)) }
  }
  FORM_COLUMNS = %w(name)
end
