module Redde::WithPhoto
  extend ActiveSupport::Concern

  QUERY = 'imageable_id = :id AND imageable_type = :type OR token in (:tokens)'.freeze

  included do
    attr_accessor :photo_tokens
    has_many :photos, dependent: :destroy, as: :imageable
    after_create :assign_photos
  end

  def all_photos
    Photo.where(QUERY, id: id, type: self.class.name, tokens: tokens)
  end

  def assign_photos
    Photo.where(token: tokens).update_all(imageable_attributes)
  end

  def imageable_attributes
    { imageable_id: id, imageable_type: self.class.name, token: nil }
  end

  def tokens
    photo_tokens || []
  end
end
