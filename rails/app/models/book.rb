class Book < ApplicationRecord

has_and_belongs_to_many :categories
has_one_attached :image

validate :image_type

private

  def image_type
    if image.attached? == false
      errors.add(:image, "is missing!")
    elsif !image.content_type.in?(%('image/jpeg image/png'))
      errors.add(:image, "needs to be a jpeg or png!")
    end
  end
end

