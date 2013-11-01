class Card < ActiveRecord::Base
  belongs_to :deck
  has_many :attempts
  has_many :rounds, through: :attempts
end
