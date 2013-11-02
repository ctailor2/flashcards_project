get '/round/:round_id/card/:card_id' do
  @round = Round.find_by_id(params[:round_id])

  if @round.complete?
    redirect to "/round/#{@round.id}/stats"
  else
  @card = Card.find_by_id(params[:card_id])
    erb :card_view
  end
end

post '/round/:round_id/card/:card_id' do
  attempt = Attempt.create(round_id: params[:round_id], card_id: params[:card_id], guess: params[:guess])
  corresponding_card = Card.find_by_id(params[:card_id])
  if attempt.guess == corresponding_card.answer
    Attempt.update(attempt.id, correct: true)
  else
    Attempt.update(attempt.id, correct: false)
  end
  redirect to "/round/#{attempt.round_id}/card/#{attempt.card_id}/attempt/#{attempt.id}"
end

get '/round/:round_id/card/:card_id/attempt/:attempt_id' do 
  @attempt = Attempt.find_by_id(params[:attempt_id])
  @round = Round.find_by_id(params[:round_id])
  @card = Card.find_by_id(params[:card_id]) 
  erb :answer_view
end

post '/deck/:deck_id/round/:round_id' do
  deck = Deck.find_by_id(params[:deck_id])

  round = Round.find_by_id(params[:round_id])

  answered_cards = []
  correct_attempts = Attempt.where(round_id: round.id, correct: true)
  correct_attempts.each do |attempt|
    answered_cards << Card.find_by_id(attempt.card_id)
  end

  unanswered_cards = deck.cards - answered_cards
  new_card = unanswered_cards.sample

  if round.complete?
    redirect to "/round/#{round.id}/stats"
  else 
    redirect to "/round/#{round.id}/card/#{new_card.id}"
  end

end


#################    CHASM OF DOOOOOOOOOOOOMMMMMM        ########################

#Chirag and Meara's side!!!!

get '/' do
  if logged_in?
    @decks = Deck.all
    erb :index
  else
    redirect to('/login')
  end
end

post '/deck/:deck_id/round/' do
  deck = Deck.find_by_id(params[:deck_id])

  user = current_user
  # Create a round 
  round = user.rounds.create(deck_id: deck.id)
  round.created_at.inspect
  # Get card from deck
  card = deck.cards.sample
  # Redirect to get round/roundid/card/cardid
  redirect to("/round/#{round.id}/card/#{card.id}")
end



get '/round/:round_id/stats' do

  @round = Round.find(params[:round_id])

  erb :stats_view

end 

# ~> NoMethodError
# ~> undefined method `get' for main:Object
# ~>
# ~> /Users/apprentice/Desktop/flashcards_project/app/controllers/index.rb:1:in `<main>'
