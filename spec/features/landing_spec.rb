require 'rails_helper'

RSpec.describe 'Landing Page' do
  describe 'when a user visits the root path' do
    it 'displays the title of the app, existing users, with links to users dashboard' do
      users = create_list(:random_user, 3)

      visit root_path

      expect(page).to have_content('Viewing Party Lite')
      expect(page).to have_link("Register as a User")
      expect(page).to have_link("#{users[0].email}'s dashboard")
      expect(page).to have_link('Home')
    end
  end

  describe 'logging in' do
    it "can log in with valid credentials" do
      user = User.create(name: "funbucket", email: 'funbucket13@gmail.com', password: "password", password_confirmation: "password")

      visit root_path

      click_on "I already have an account"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Log In"
      expect(current_path).to eq(users_path)


      expect(page).to have_content("Welcome, #{user.name}")
    end

    it "cannot log in with bad credentials" do
      user = User.create(name: "funbucket", email: "funbucket13@gmail.com", password: "password", password_confirmation: "password")

      # we don't have to go through root_path and click the "I have an account" link any more
      visit login_path

      fill_in :email, with: user.email

      fill_in :password, with: "incorrect password"

      click_on "Log In"

      expect(current_path).to eq(login_path)

      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end
