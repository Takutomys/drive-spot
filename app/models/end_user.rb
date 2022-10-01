class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com', screen_name: 'ゲストユーザー') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
    end
  end

  enum gender: { male: 0, female: 1, others: 2 }
end
