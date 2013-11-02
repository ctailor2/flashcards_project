class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :attempts
  has_many :cards, through: :attempts

  def complete?
    # if number of attempts in round is same or larger than number of cards in the deck
    # number_of_attempts = self.attempts.count
    number_of_cards_in_deck = Deck.find_by_id(self.deck_id).cards.count
    # number_of_attempts >= number_of_cards_in_deck

    Attempt.where(round_id: self.id, correct: true).length >= number_of_cards_in_deck

  end
end
