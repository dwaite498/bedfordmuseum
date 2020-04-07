class StaticPage < ApplicationRecord
  validates_uniqueness_of :homepage
end
