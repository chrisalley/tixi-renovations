class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumbnail do
    process resize_to_fill: [150, 100]
  end

  version :mobile do
    process resize_to_fill: [300, 200]
  end

  version :desktop do
    process resize_to_fill: [400, 267]
  end

  version :popover do
    process resize_to_fill: [600, 400]
  end

  def extension_white_list
    %w(jpg jpeg)
  end

  def filename
    "photo.jpg"
  end
end
