require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
  it { is_expected.to belong_to :user }

  it 'is not valid with a name of less than 3 characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it { should validate_uniqueness_of(:name)}

  # it 'is not valid unless it has a unique name' do
  #   user = User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
  #   user.restaurants.create(name: "Moe's Tavern")
  #   restaurant = Restaurant.new(name: "Moe's Tavern")
  #   expect(restaurant).to_not have(1).error_on(:name)
  # end
end
