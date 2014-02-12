class Photo < ActiveRecord::Base
  # belongs_to :product

  default_scope { order(:position) }

  mount_uploader :src, PhotoUploader
end