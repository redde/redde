class Redde::Photo < ActiveRecord::Base
  mount_uploader :src, PhotoUploader
  self.table_name = 'redde_photos'

  belongs_to :imageable, polymorphic: true
  default_scope { order(:position) }
  before_save :set_token, unless: :persisted_link?

  def set_token
    self.token = SecureRandom.uuid unless token.present?
  end

  def persisted_link?
    imageable_type.present? && imageable_id.present?
  end
end
