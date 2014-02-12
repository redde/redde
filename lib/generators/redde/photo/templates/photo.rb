class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  default_scope { order(:position) }

  mount_uploader :src, PhotoUploader
end