class ImageFileTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      file_type = File::extname(value.to_s)
      file_types = %w(.jpg .jpeg .png .gif)
      record.errors[attribute] << I18n.t('errors.messages.invalid_image') unless file_types.include?(file_type)
    end
  end
end

class Photo < ApplicationRecord
  mount_uploader :picture, PictureUploader, mount_on: :file_name
  
  before_save :update_asset_attributes
  
  validates :title, presence: true
  validates :title, length: { in: 1..30 } 

  validates :picture, presence: true, image_file_type: true
end
