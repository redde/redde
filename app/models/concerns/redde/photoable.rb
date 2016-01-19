module Redde::Photoable
  extend ActiveSupport::Concern

  included do
    belongs_to :imageable, polymorphic: true
    default_scope { order(:position) }
    before_save :set_token, unless: :persisted_link?
  end

  def set_token
    self.token = SecureRandom.uuid unless token.present?
  end

  def persisted_link?
    imageable_type.present? && imageable_id.present?
  end
end
