require 'rails_helper'

RSpec.describe User, type: :model do
  it 'exists' do
    user_1 = User.create!(name: 'John', email: 'x@user.com', password: 'password', password_confirmation: 'password')
    expect(user_1).to be_instance_of(User)

  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:password_confirmation)}
  end

  describe 'relationships' do
    it { should have_many(:user_parties) }
    it { should have_many(:parties).through(:user_parties) }
  end

  it 'encrypts passwords' do
    user = User.create!(name: 'John', email: 'x@user.com', password: 'password', password_confirmation: 'password')
    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq('password')
  end
end
