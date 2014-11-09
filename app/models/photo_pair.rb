class PhotoPair < ActiveRecord::Base
  validates :before_photo, presence: true
  validates :after_photo, presence: true

  mount_uploader :before_photo, PhotoUploader
  mount_uploader :after_photo, PhotoUploader
end
