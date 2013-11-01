class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :attempts
  has_many :cards, through: :attempts
end
