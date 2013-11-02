class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :attempts
  has_many :cards, through: :attempts

  def complete?
    # if number of attempts in round is same or larger than number of cards in the deck
    # number_of_attempts = self.attempts.count
    number_of_cards_in_deck = deck.cards.count
    # number_of_attempts >= number_of_cards_in_deck

    Attempt.where(round_id: self.id, correct: true).length >= number_of_cards_in_deck

  end

  def deck
    Deck.find_by_id(self.deck_id)
  end

  def num_correct_attempts
    Attempt.where(round_id: self.id, correct: true).length
  end

  def num_incorrect_attempts
    nils = Attempt.where(round_id: self.id, correct: nil).length
    falses = Attempt.where(round_id: self.id, correct: false).length
    nils + falses
  end

  def num_total_attempts
    num_correct_attempts + num_incorrect_attempts
  end

  def percent_correct
    decimal = num_correct_attempts.to_f/num_total_attempts
    percentage = (decimal * 100).round(2)
  end

  def avg_num_guesses
    (num_total_attempts.to_f / deck.cards.count).round(2)
  end

end
