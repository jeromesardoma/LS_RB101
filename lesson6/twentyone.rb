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
end

def remove_card!(card, deck)
  deck.delete card
end

def player(type)
  { type: type, hand: [] }
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
  value = case card
          when ace then 11
          when card.split.first.to_i == 0 then 10
          else card.split.first.to_i
          end
  value
end

def total_value(hand)
  score = hand.map { |card| calculate_value(card) }.reduce(:+)
  score - 10 if hand.any? { |card| card.start_with?('A') } && score > 21
  score
end

def display_total_value(hand)
  score_prompt "Total is: #{total_value(hand)}."
end

def player_busted?(player)
  total_value(player[:hand]) > 21
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
  until total_value(dealer[:hand]) >= 17
    deal_card(deck, dealer)
  end
end

def evaluate_winner(dealer, human)
  if player_busted?(dealer)
    prompt 'Dealer busted.  You win!'
  elsif total_value(dealer[:hand]) > total_value(human[:hand])
    prompt 'Dealer wins.  You lose.'
  elsif total_value(human[:hand]) > total_value(dealer[:hand])
    prompt 'Dealer lost.  You win!'
  elsif total_value(dealer[:hand]) == total_value(human[:hand])
    prompt "It's a push."
  end
end

# BEGIN PROGRAM

loop do
  human = player('human')
  dealer = player('dealer')
  deck = initialize_deck

  system 'clear'
  prompt 'Welcome to Blackjack!'
  2.times { deal_card(deck, human) }
  2.times { deal_card(deck, dealer) }

  loop do
    display_hand dealer
    display_hand human
    display_total_value(human[:hand])
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
    display_total_value(dealer[:hand])
    display_hand human
    display_total_value(human[:hand])
    evaluate_winner(dealer, human)
  end

  break unless prompt_to_play_again == 'yes'
end

prompt 'Thanks for playing blackjack! Bye.'
