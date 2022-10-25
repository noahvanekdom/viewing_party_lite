class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :password_confirmation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  before_save { self.email = email.downcase }

  has_many :user_parties
  has_many :parties, through: :user_parties


  def host_status(party_id)
    user_parties.where(party_id: party_id).pluck("host_status").first
  end
end
