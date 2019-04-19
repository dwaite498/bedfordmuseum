class Book < ApplicationRecord
  
  has_one_attached :image
  
  validate :image_type
  
  def image_type
    if image.attached? == false
      errors.add(:image, "is missing!")
    end
    if !image.content_type.in?(%('image/jpeg image/png'))
      errors.add(:image, "needs to be a jpeg or png!")
    end
  end
end
