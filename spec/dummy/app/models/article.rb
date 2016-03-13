class Article < ActiveRecord::Base
  INDEX_COLUMNS = %w(title published_at)
  include Redde::WithPhoto
  mount_uploader :preview, ArticleUploader
  validates :title, presence: true
end
