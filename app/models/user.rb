class User < ActiveRecord::Base
  has_many :rounds
  has_many :attempts, through: :rounds
  validates :name, :email, :password, presence: true 
  validates :email, :uniqueness => true

  # May also want to add index to migration to enforce uniqueness.

  def self.authenticate(email, password)
    User.find_by_email_and_password(email, password)
  end

  def self.exists?(email)
    !User.find_by_email(email).nil?
  end

end
