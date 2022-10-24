require 'rails_helper'

RSpec.describe 'Users discover page' do
  describe 'when users visit a discover page' do
    before :each do
      @user = User.create!(name: 'John', email: 'john@user.com', password: 'password', password_confirmation: 'password')
      visit user_discover_path(@user)
    end

    it 'can search by top rated movies', :vcr do
      #   As an user,
      # When I visit the '/users/:id/discover' path, where :id, is the id of a valid user,
      # I should see
      # _ Button to Discover Top Rated Movies
      expect(page).to have_button('Discover Top Rated Movies')
      click_button('Discover Top Rated Movies')
      # _ A text field to enter keyword(s) to search by movie title
      expect(current_path).to eq(user_movies_path(@user))
    end

    it 'can search by movie title', :vcr do
      # expect(page).to have_field('search')
      fill_in 'search', with: 'y'
      # _ A Button to Search by Movie Title
      expect(page).to have_button('Search by movie title')
      click_button('Search by movie title')
      expect(current_path).to eq(user_movies_path(@user))
    end

    it 'will not search without search field input', :vcr do
      click_button('Search by movie title')
      expect(current_path).to eq user_discover_path(@user)
      expect(page).to have_content("Search Field Can't Be Blank")
    end
  end
end
