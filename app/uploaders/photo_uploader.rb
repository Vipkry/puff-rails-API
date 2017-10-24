class PhotoUploader < CarrierWave::Uploader::Base include Cloudinary::CarrierWave
 
  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end
 
end