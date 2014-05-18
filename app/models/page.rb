class Page < ActiveRecord::Base
  include Sluggable

  validates :name, presence: true, length: { in: 1..75 }, uniqueness: true
end
