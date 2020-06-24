require 'pry'

CARD_FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
SUITS = ['spades', 'diamonds', 'hearts', 'clubs']

def prompt(message)
  puts "==> " + message
end

def score_prompt(message)
  puts "====> " + message
end

def initialize_deck
  deck = CARD_FACES.each_with_object([]) do |face, new_ary|
    new_ary << SUITS.map do |suit|
      "#{face} of #{suit}"
    end
  end
  deck.flatten
end

def deal_card(deck, recipient)
  card = deck.sample
  remove_card!(card, deck)
  recipient[:hand] << card
  recipient[:hand_value] += calculate_value(card)
end

def remove_card!(card, deck)
  deck.delete card
end

def player(type)
  { type: type, 
    hand: [],
    hand_value: 0,
    score: 0 } 
end

def display_hand(player, dealers_turn = false)
  if player[:type] == 'human'
    puts "You have: "
    player[:hand].each { |card| prompt card }
  elsif player[:type] == 'dealer' && dealers_turn == false
    puts "Dealer has: "
    prompt player[:hand].first
  elsif player[:type] == 'dealer' && dealers_turn == true
    puts "Dealer has: "
    player[:hand].each { |card| prompt card }
  end
end

def calculate_value(card)
  ace = card.start_with?('A')
  value = case
          when ace then 11
          when card.split.first.to_i == 0 then 10
          else card.split.first.to_i
          end
  value
end

def display_total_value(player)
  score_prompt "Total is: #{player[:hand_value]}."
end

def player_busted?(player)
  player[:hand_value] > 21
end

def retrieve_player_action
  response = ''
  loop do
    puts '---------- Hit or Stay? ----------'
    response = gets.chomp
    break if response.start_with?(/h|s/i)
    puts 'You entered an invalid value, try again.'
  end
  'hit' if response.downcase.start_with? 'h'
  'stay' if response.downcase.start_with? 's'
end

def prompt_to_play_again
  prompt "Play again?"
  response = gets.chomp
  return 'yes' if response.downcase.start_with? 'y'
  'no'
end

def handle_dealer_turn(dealer, deck)
  until dealer[:hand_value] >= 17
    deal_card(deck, dealer)
  end
end

def evaluate_winner(player1, player2)
  dealer = [player1, player2].select { |person| person[:type] == 'dealer' }[0]
  human = [player1, player2].select { |person| person[:type] == 'human' }[0]
  if player_busted?(dealer)
    prompt 'Dealer busted.  You win!'
  elsif dealer[:hand_value] > human[:hand_value]
    prompt 'Dealer wins.  You lose.'
  elsif human[:hand_value] > dealer[:hand_value]
    prompt 'Dealer lost.  You win!'
  elsif dealer[:hand_value] == human[:hand_value]
    prompt "It's a push."
  end
end

def return_winner(player1, player2)
  dealer = [player1, player2].select { |person| person[:type] == 'dealer' }[0]
  human = [player1, player2].select { |person| person[:type] == 'human' }[0]
  if player_busted?(dealer)
    human
  elsif player_busted?(human)
    dealer
  elsif dealer[:hand_value] > human[:hand_value]
    dealer
  elsif human[:hand_value] > dealer[:hand_value]
    human
  end
end

def increment_winner_score(player1, player2)
  winner = return_winner(player1, player2)
  winner[:score] += 1 if winner
end

def display_game_score(dealer, human)
  score_prompt "SCORE: Dealer #{dealer[:score]}, You #{human[:score]}."
end

def initialize_players_hands(dealer, human)
  [dealer, human].each do |person|
    person[:hand] = []
    person[:hand_value] = 0
  end
end

def initialize_players_scores(p1, p2)
  [p1, p2].each { |p| p[:score] = 0 } 
end

def grand_winner?(player1, player2)
  [player1, player2].any? { |player| player[:score] == 5 }
end

def return_grand_winner(player1, player2)
  [player1, player2].select { |player| player[:score] == 5 }.first
end

# BEGIN PROGRAM

loop do
  human = player('human')
  dealer = player('dealer')
  end_game = false

  loop do
    deck = initialize_deck
    initialize_players_hands(dealer, human)
    initialize_players_scores(dealer, human) if grand_winner?(dealer, human)
  
    system 'clear'
    prompt 'Welcome to Blackjack!'
    2.times { deal_card(deck, human) }
    2.times { deal_card(deck, dealer) }
  
    loop do
      display_game_score(dealer, human)
      display_hand dealer
      display_hand human
      display_total_value human
      break if player_busted?(human) || retrieve_player_action == 'stay'
      deal_card(deck, human)
      system 'clear'
    end
  
    if player_busted?(human)
      prompt 'You busted.'
    else
      system 'clear'
      handle_dealer_turn(dealer, deck)
      display_hand(dealer, true)
      display_total_value dealer
      display_hand human
      display_total_value human
      evaluate_winner(dealer, human)
    end

    increment_winner_score(dealer, human)

    if grand_winner?(dealer, human)
      prompt "#{return_grand_winner(dealer, human)[:type].capitalize} is the grand winner!"
    end

    unless prompt_to_play_again == 'yes'
      end_game = true
      break
    end
  end

  break if end_game == true
end



prompt 'Thanks for playing blackjack! Bye.'
