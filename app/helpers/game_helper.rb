helpers do 
def new_card(round)
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

def continue_round?(deck, user)
  round = Round.where(user_id: user.id, deck_id: deck.id).last
  if round
    !round.complete?
  else
    false
  end
end


def stats_messages(round)
  percentage = round.percent_correct
  messages = Hash.new
  case percentage
  when 100
    messages[:h1] = 'Perfect score!'
    messages[:h3] =  'Crushing it.'
  when 85..100
    messages[:h1] = 'Good effort.'
    messages[:h3] =  'Typing is hard.'
  when 70..85
    messages[:h1] = 'Can I give you some feedback?'
    messages[:h3] = 'Just take one tissue.'
  else
    messages[:h1] = 'Really?'
    messages[:h3] =  'Your score offends me.'
  end
  messages
end




end
