class Tweet < ApplicationRecord
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  geocoded_by :address
  after_validation :geocode

  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end
end
