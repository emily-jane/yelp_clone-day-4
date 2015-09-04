require 'rails_helper'

feature 'reviewing' do
  before(:each) do
    sign_up
    user = User.last
    user.restaurants.create(name: 'KFC')
  end

  scenario 'allows users to leave a review using a form' do
    visit restaurants_path
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq restaurants_path
    expect(page).to have_content('so so')
  end

  scenario 'user can only leave one review per restaurant' do
    visit restaurants_path
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'
    expect(page).to have_content('You can only leave one review')
    expect(current_path).to eq restaurants_path
  end

  # scenario 'another user can review a restaurant that already has a review'
  # end
 end
