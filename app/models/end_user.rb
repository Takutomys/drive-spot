class EndUser < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com', screen_name: 'ゲストユーザー') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
    end
  end

  enum gender: { male: 0, female: 1, others: 2 }
  enum status: { nonreleased: 0, released: 1 }

  has_one_attached :profile_image

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit: [10, 10]).processed
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end
end