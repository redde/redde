class Article < ActiveRecord::Base
  include Redde::WithPhoto
  validates :title, presence: true
end
