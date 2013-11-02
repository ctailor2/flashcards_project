get '/round/:round_id/card/:card_id' do
  @round = Round.find_by_id(params[:round_id])

  if @round.complete?
    redirect to "/round/#{@round.id}/stats"
  else
  @card = Card.find_by_id(params[:card_id])
    erb :card_view
  end
  # erb :card_view
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
  # Will have to grab user from session once that is implemented
  user = User.find_by_id(1)
  round = Round.find_by_id(params[:round_id])
  card = deck.cards.find_by_id(2)
  redirect to "/round/#{round.id}/card/#{card.id}"
end
#################    CHASM OF DOOOOOOOOOOOOMMMMMM        ########################

#Chirag and Meara's side!!!!

get '/' do
  # list decks
  # decks are clickable
  # deck links to post with deck_id

  @decks = Deck.all

  erb :index
end

post '/deck/:deck_id/round/' do
  deck = Deck.find_by_id(params[:deck_id])
  # Will have to grab user from session once that is implemented
  user = User.find_by_id(1)
  # Create a round 
  round = user.rounds.create(deck_id: deck.id)
  round.created_at.inspect
  # Get card from deck
  card = deck.cards.first
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
