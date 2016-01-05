class Photo < ActiveRecord::Base
  include Redde::Photoable
  mount_uploader :src, PhotoUploader
end
