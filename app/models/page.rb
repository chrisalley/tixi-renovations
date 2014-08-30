class Page < ActiveRecord::Base
  include Sluggable

  validates :name, presence: true, length: { in: 1..75 }, uniqueness: true

  before_validation :prevent_reserved_name

  private

  def prevent_reserved_name
    if self.slug.in?(['gallery', 'log-in', 'log-out', 'pages', 'photos', 'users'])
      self.errors.add(name, 'is a reserved word. Choose a different name.')
    end
  end
end
