class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :tweet
  validates :comment, presence: true
end
