class StaticPage < ApplicationRecord
  validates :homepage,  uniqueness: true, if: :homepage
end
