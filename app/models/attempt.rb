class Attempt < ActiveRecord::Base
  belongs_to :round
  belongs_to :card
end
