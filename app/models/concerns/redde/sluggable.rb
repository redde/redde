module Redde::Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug,
              format: {
                with: /\A[A-z0-9_-]*\z/i,
                message: 'имеет неверный формат, разрешены английские символы, знак подчеркивания "_" и дефис "-"'
              },
              presence: true
    before_validation :set_slug
  end

  def set_slug
    self.slug = Redde::UrlGenerator.new(self, title_field).formatted_name.downcase unless slug.present?
  end

  def title_field
    send(title_symbol)
  end

  def title_symbol
    self.class::TITLE_SYMBOL
  rescue
    :title
  end

  def to_param
    "#{id}-#{slug.try(:downcase)}"
  end
end
