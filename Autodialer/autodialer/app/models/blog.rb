class Blog < ApplicationRecord
  before_create :set_slug
  validates :title, presence: true

  def set_slug
    self.slug ||= title.parameterize
  end
end