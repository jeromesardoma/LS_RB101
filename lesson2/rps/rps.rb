VALID_CHOICES = %w(rock paper scissors spock lizard).freeze
# freeze to prevent variable from mutating

def display_results(player, computer)
  if win?(player, computer)
    prompt 'You won!'
  elsif win?(computer, player)
    prompt 'You lost!'
  else
    prompt "It's a tie!"
  end
end

def return_results(player, computer)
  if win?(player, computer)
    'player'
  elsif win?(computer, player)
    'computer'
  else
    'none'
  end
end

def win?(first, second)
  win_hash = {
    rock: %w(lizard scissors),
    paper: %w(rock spock),
    scissors: %w(lizard paper),
    lizard: %w(paper spock),
    spock: %w(rock scissors)
  }
  win_hash[first.to_sym].include? second
end

def display_score(score1, score2)
  prompt "Your score is #{score1}. Computer's score is #{score2}."
end

def check_for_grand_winner(score1, score2)
  if score1 == 5
    prompt "You're the grand winner, congrats!"
  elsif score2 == 5
    prompt 'Computer is the grand winner.  Better luck next time!'
  end
end

def prompt(message)
  puts "=> #{message}"
end

# BEGIN PROGRAM

human_score = 0
computer_score = 0

loop do
  choice = ''

  loop do
    choice_message = <<-MSG
    You can enter: R for rock   P for paper   SC for scissors
                   SP for spock L for lizard
    MSG

    prompt "Choose one: #{VALID_CHOICES.join(',')}"
    prompt choice_message
    choice = gets.chomp
    break if %w(r p sc sp l).include?(choice.downcase)
    prompt "That's not a valid choice, try again."
  end

  computer_choice = VALID_CHOICES.sample
  choice_hash = %w(r p sc sp l).zip(VALID_CHOICES).to_h
  prompt "You chose #{choice_hash[choice]}. Computer chose #{computer_choice}."

  display_results(choice_hash[choice], computer_choice)

  winner = return_results(choice_hash[choice], computer_choice)
  human_score += 1 if winner == 'player'
  computer_score += 1 if winner == 'computer'

  display_score(human_score, computer_score)
  check_for_grand_winner(human_score, computer_score)

  prompt 'Do you want to play again?'
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'

  if human_score == 5 || computer_score == 5
    human_score = 0
    computer_score = 0
  end
end
