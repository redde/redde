module WithPhoto
  extend ActiveSupport::Concern

  included do
    attr_accessor :tokens
    has_many :photos, dependent: :destroy, as: :imageable
    after_create :assign_photos
  end

  def assign_photos
    Photo.where(token: tokens || []).update_all(imageable_id: self.id, imageable_type: self.class.name)
  end
end
