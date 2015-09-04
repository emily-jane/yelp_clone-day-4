require 'rails_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }

  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

  describe 'it can be deleted as a specific user' do
    it 'can be deleted by the user that created it' do
      user = User.new(email: "joe@joe.com", password: "testtest", password_confirmation: "testtest")
      review = Review.create(user: user, thoughts: "stuff", rating: 2)

      expect{review.destroy_as(user)}.to change { Review.count }.by(-1)
    end

    it 'can be deleted by the user that created it' do
      user = User.create(email: "joe@joe.com", password: "testtest", password_confirmation: "testtest")
      user2 = User.create(email: "joe@joe2.com", password: "testtest", password_confirmation: "testtest")
      review = Review.create(user: user, thoughts: "stuff", rating: 2)

      expect {review.destroy_as(user2)}.to_not change { Review.count }
    end
  end
end
