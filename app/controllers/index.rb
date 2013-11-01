

post '/deck/:deck_id/round/' do
  # deck = Deck.find_by_id(params[:deck_id])
  
  # Create a round 
  # round = deck.round.create()

  # Get card from deck

  # Redirect to get round/roundid/card/cardid
end

get '/round/:round_id/card/:card_id' do
  # if round complete
  # redirect to '/round/:round_id/stats'
  # else
  # render card view
  erb :card_view


end

post '/round/:round_id/card/:card_id' do
  # insantiate attempt using round id, card id, and user input
  # check if user input is equal to card answer
  # update attempt whether guessed correctly
  redirect to '/round/:round_id/card/:card_id/attempt/:attempt_id'
end


#################    CHASM OF DOOOOOOOOOOOOMMMMMM        ########################


get '/' do
  # list decks
  # decks are clickable
  # deck links to post with deck_id


  erb :index
end


get '/round/:round_id/card/:card_id/attempt/:attempt_id' do 
  # cature attempt in variable
  erb :answer_view
end

get '/round/:round_id/stats' do
  erb :stats_view

end 
