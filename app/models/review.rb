class Review < ActiveRecord::Base

  belongs_to :restaurant
  belongs_to :user
  validates :user, uniqueness: { scope: :restaurant, message: 'You can only leave one review' }

  validates :rating, inclusion: (1..5)
end
