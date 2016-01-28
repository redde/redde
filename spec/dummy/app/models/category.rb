class Category < ActiveRecord::Base
  has_ancestry
  extend Redde::TreeSortable
end
