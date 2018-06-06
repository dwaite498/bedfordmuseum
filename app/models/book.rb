class Book < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_attached_file :image, styles: { medium: "450x450>", thumb: "150x150>" }, default_url: ActionController::Base.helpers.image_path("missingimage.jpg")
  validates_with AttachmentContentTypeValidator, attributes: :image,
  content_type: ["image/jpeg", "image/gif", "image/png"]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes
  extend FriendlyId
  friendly_id :title, use: :slugged
end
