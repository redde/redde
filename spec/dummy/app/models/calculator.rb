class Calculator < ActiveRecord::Base
  INDEX_COLUMNS = {
    name: '',
    hop: "link_to \"На сайт (#{2 * 2})\", root_url"
  }
  FORM_COLUMNS = %w(name)
end
