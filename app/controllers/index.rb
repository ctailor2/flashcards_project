get '/round/:round_id/card/:card_id' do
  @round = Round.find_by_id(params[:round_id])

  if @round.complete?
    redirect to "/round/#{@round.id}/stats"
  else
    erb :card_view
  end
end

post '/round/:round_id/card/:card_id' do
  # insantiate attempt using round id, card id, and user input
  # check if user input is equal to card answer
  # update attempt whether guessed correctly
  redirect to '/round/:round_id/card/:card_id/attempt/:attempt_id'
end

get '/round/:round_id/card/:card_id/attempt/:attempt_id' do 
  # cature attempt in variable
  erb :answer_view
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
