class Tweet < ApplicationRecord
  belongs_to :end_user
  has_one_attached :image

  geocoded_by :address
  after_validation :geocode
end
