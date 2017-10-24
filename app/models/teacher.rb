class Teacher < ApplicationRecord
    #mount_base64_uploader :photo, PhotoUploader
    has_many :ratings
end
