class Article < ActiveRecord::Base
  INDEX_COLUMNS = %w(title published_at)
  include Redde::WithPhoto
  validates :title, presence: true
end
