VALID_CHOICES = %w(rock paper scissors)

def display_results(player, computer)
  if (player == 'rock' && computer == 'scissors') ||
      (player == 'paper' && computer == 'rock') ||
      (player == 'scissors' && computer == 'paper')
      prompt 'You won!'
  elsif
    (player == 'rock' && computer == 'paper') ||
      (player == 'paper' && computer == 'scissors') ||
      (player == 'scissors' && computer == 'rock')
      prompt 'You lost!'
  else
    prompt "It's a tie!"
  end
end

def prompt(message)
  puts "=> #{message}"
end

loop do
  choice = ''

  loop do
    prompt "Choose one: #{VALID_CHOICES.join(",")}"
    choice = gets.chomp
    VALID_CHOICES.include?(choice) ? break : prompt("That's not a valid choice, try again.")
  end

  computer_choice = VALID_CHOICES.sample

  puts "You chose #{choice}. Computer chose #{computer_choice}."

  display_results(choice, computer_choice)

  prompt 'Do you want to play again?'
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'

end
