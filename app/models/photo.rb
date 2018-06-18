class Photo < ApplicationRecord
  mount_uploader :picture, PictureUploader
  
  validates :title, presence: true
  validates :title, length: { in: 1..30 } 
  validates :picture, presence: true
end
