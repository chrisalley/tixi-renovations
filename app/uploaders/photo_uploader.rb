class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumbnail do
    process resize_to_fit: [300, 300]
  end

  version :regular do
    process resize_to_fit: [600, 600]
  end

  def extension_white_list
    %w(jpg jpeg)
  end

  def filename
    "photo.jpg"
  end
end
