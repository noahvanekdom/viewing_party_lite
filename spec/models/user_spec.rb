require 'rails_helper'

RSpec.describe User, type: :model do
  it 'exists' do
    user_1 = User.create!(name: 'John', email: 'x@user.com', password: 'test')
    expect(user_1).to be_instance_of(User)
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password}
  end

  describe 'relationships' do
    it { should have_many(:user_parties) }
    it { should have_many(:parties).through(:user_parties) }
  end

  it 'will store the information of the user encrypted' do
    user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq('password123')
  end
end
