class Article < ActiveRecord::Base
  include Redde::WithPhoto
  mount_uploader :preview, ArticleUploader
  validates :title, presence: true
end
