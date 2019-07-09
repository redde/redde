class Redde::Photo < ActiveRecord::Base
  mount_uploader :src, PhotoUploader
  self.table_name = 'redde_photos'

  if Rails.version.split('.').join.to_i > 510
    belongs_to :imageable, polymorphic: true, optional: true
  else
    belongs_to :imageable, polymorphic: true
  end
  default_scope { order(:position) }
  before_save :set_token, unless: :persisted_link?

  def set_token
    self.token = SecureRandom.uuid unless token.present?
  end

  def persisted_link?
    imageable_type.present? && imageable_id.present?
  end
end
