class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password
  validates_presence_of :password_confirmation

  has_secure_password


  has_many :user_parties
  has_many :parties, through: :user_parties


  def host_status(party_id)
    user_parties.where(party_id: party_id).pluck("host_status").first
  end
end
