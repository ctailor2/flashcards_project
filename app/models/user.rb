class User < ActiveRecord::Base
  has_many :rounds
  has_many :attempts, through: :rounds
end
