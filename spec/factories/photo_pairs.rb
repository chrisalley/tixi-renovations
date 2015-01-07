FactoryGirl.define do
  factory :photo_pair do
    factory :valid_photo_pair do
      before_photo Rack::Test::UploadedFile.new(
        'spec/fixtures/photo.jpg', 'image/jpeg')
      after_photo Rack::Test::UploadedFile.new(
        'spec/fixtures/photo.jpg', 'image/jpeg')

      factory :published_photo_pair do
        published true
      end
    end
  end
end
