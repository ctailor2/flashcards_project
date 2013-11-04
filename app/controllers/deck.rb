get '/newdeck' do
  redirect to('/login') unless logged_in?
  @user = current_user
  erb :create_deck
end

post '/newdeck' do
  questions = params[:questions]
  answers = params[:answers]

  qa_pairs = questions.zip(answers)
  deck = Deck.create(title: params[:title])

  qa_pairs.each do |qa_pair|
    deck.cards.create(question: qa_pair[0], answer: qa_pair[1])
  end

  redirect to('/')
end
