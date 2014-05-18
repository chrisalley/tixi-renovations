module Sluggable
  extend ActiveSupport::Concern

  included do
    acts_as_url :name, sync_url: true, url_attribute: :slug

    validates :slug, presence: true, uniqueness: true
  end

  def to_param
    slug
  end
end
