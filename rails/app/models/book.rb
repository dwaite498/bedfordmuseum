class Book < ApplicationRecord
  
  has_one_attached :image

validate :image_type

private

  def image_type
    if image.attached? == false
      errors.add(:image, "is missing!")
    elsif !image.content_type.in?(%('image/jpg image/png'))
      errors.add(:image, "needs to be a jpg or png!")
    end
  end
end
