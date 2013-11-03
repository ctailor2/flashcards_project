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
  check_answer(corresponding_card, attempt)
  redirect to "/round/#{attempt.round_id}/card/#{attempt.card_id}/attempt/#{attempt.id}"
end

get '/round/:round_id/card/:card_id/attempt/:attempt_id' do 
  @attempt = Attempt.find_by_id(params[:attempt_id])
  @round = Round.find_by_id(params[:round_id])
  @card = Card.find_by_id(params[:card_id]) 
  erb :answer_view
end

post '/deck/:deck_id/round/:round_id' do
  round = Round.find_by_id(params[:round_id])

  if round.complete?
    redirect to "/round/#{round.id}/stats"
  else 
    redirect to "/round/#{round.id}/card/#{new_card(round).id}"
  end

end


#################    CHASM OF DOOOOOOOOOOOOMMMMMM        ########################

get '/' do
  if logged_in?
    @decks = Deck.all
    @user = current_user
    erb :index
  else
    redirect to('/login')
  end
end

post '/deck/:deck_id/newround' do
  deck = Deck.find_by_id(params[:deck_id])
  user = current_user
  round = user.rounds.create(deck_id: deck.id)
  card = deck.cards.sample
  redirect to("/round/#{round.id}/card/#{card.id}")
end

post '/deck/:deck_id/continueround' do
  deck = Deck.find_by_id(params[:deck_id])
  user = current_user
  round = Round.order("created_at DESC").find_by_user_id_and_deck_id(user.id, deck.id)
  
  # need to figure out a way to call new card helper method successfully
  card = new_card(round)
  redirect to("/round/#{round.id}/card/#{card.id}")
end


get '/round/:round_id/stats' do
  @round = Round.find(params[:round_id])
  erb :stats_view
end 
