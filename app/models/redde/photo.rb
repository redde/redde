class Redde::Photo < ActiveRecord::Base
  mount_uploader :src, PhotoUploader
  self.table_name = 'redde_photos'

  opts = { polymorphic: true }
  opts.merge!(optional: true) if Rails.version.split('.')[0..1].join.to_i >= 51
  
  belongs_to :imageable, opts

  default_scope { order(:position) }
  before_save :set_token, unless: :persisted_link?

  def set_token
    self.token = SecureRandom.uuid unless token.present?
  end

  def persisted_link?
    imageable_type.present? && imageable_id.present?
  end
end
