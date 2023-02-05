class Tweet < ApplicationRecord
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :spot_name, presence: true
  validates :introduction, presence: true
  validates :prefectures, presence: true

  geocoded_by :address
  after_validation :geocode

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/others_501.png')
      image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [350,350]).processed
  end

  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

end
