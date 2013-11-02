def new_card(round)
  round = Round.find_by_id(params[:round_id])
  deck = round.deck

  answered_cards = []
  correct_attempts = Attempt.where(round_id: round.id, correct: true)
  correct_attempts.each do |attempt|
    answered_cards << Card.find_by_id(attempt.card_id)
  end

  unanswered_cards = deck.cards - answered_cards
  new_card = unanswered_cards.sample
end

def check_answer(card, attempt)
  simple_guess = attempt.guess.downcase.gsub(/\W*/x, "")
  simple_answer = card.answer.downcase.gsub(/\W*/x, "")
  if simple_guess == simple_answer
    Attempt.update(attempt.id, correct: true)
  else
    Attempt.update(attempt.id, correct: false)
  end
end
