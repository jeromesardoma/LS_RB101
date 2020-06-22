require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]]

def prompt(message)
  puts "==> #{message}"
end

def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts "#{brd[1]}|#{brd[2]}|#{brd[3]}"
  puts '-----'
  puts "#{brd[4]}|#{brd[5]}|#{brd[6]}"
  puts '-----'
  puts "#{brd[7]}|#{brd[8]}|#{brd[9]}"
end

def display_scores(score_hsh)
  puts "Player score is #{score_hsh['Player']}."
  puts "Computer score is #{score_hsh['Computer']}."
end

def initialize_board
  new_board = {}
  (1..9).each { |n| new_board[n] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |n| brd[n] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{join_or(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include? square
    prompt 'Sorry, not a valid choice.'
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = 0
  if computer_poses_threat?(brd)
    winning_c_line = almost_winning_lines(brd, 'Computer').sample
    square = brd.select { |k, _| winning_c_line.include?(k) }.key(INITIAL_MARKER)
  elsif player_poses_threat?(brd)
    winning_p_line = almost_winning_lines(brd, 'Player').sample
    square = brd.select { |k, _| winning_p_line.include?(k) }.key(INITIAL_MARKER)
  elsif brd[5] == INITIAL_MARKER
    square = 5
  else
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd) # want to return a true boolean
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def join_or(arr, delimiter=',', end_delimiter='or')
  case arr.size
  when 0 then ''
  when 1 then arr[0]
  when 2 then arr.join(" #{end_delimiter} ")
  else
    arr[-1] = "#{end_delimiter} #{arr.last}"
    arr.join(delimiter + ' ')
  end
end

def scores
  { 'Player' => 0, 'Computer' => 0 }
end

def grand_winner?(scores)
  scores.values.any? { |score| score == 5 }
end

def player_poses_threat?(brd)
  !almost_winning_lines(brd, 'Player').empty?
end

def computer_poses_threat?(brd)
  !almost_winning_lines(brd, 'Computer').empty?
end

def almost_winning_lines(brd, player_or_computer)
  marker = ''
  marker = PLAYER_MARKER if player_or_computer == 'Player'
  marker = COMPUTER_MARKER if player_or_computer == 'Computer'
  WINNING_LINES.select do |line|
    brd.values_at(*line).count(marker) == 2 &&
      brd.values_at(*line).count(INITIAL_MARKER) == 1
  end
end

def select_starting_player
  selection = ''
  loop do
    prompt 'Who would you like to go first: (p)layer or (c)omputer?'
    selection = gets.chomp
    break if selection.downcase.start_with?(/c|p/i)
    prompt 'You entered an invalid entry, try again.'
  end
  selection.downcase.start_with?('p') ? 'Player' : 'Computer'
end

def switch_player(player)
  player == 'Player' ? 'Computer' : 'Player'
end

def place_piece!(brd, player)
  player_places_piece!(brd) if player == 'Player'
  computer_places_piece!(brd) if player == 'Computer'
end

# BEGIN PROGRAM

loop do
  game_scores = scores
  continue = ''

  loop do
    board = initialize_board
    current_player = select_starting_player

    loop do
      display_board(board)
      display_scores(game_scores)
      place_piece!(board, current_player)
      break if someone_won?(board) || board_full?(board)
      current_player = switch_player(current_player)
    end

    display_board(board)
    if someone_won?(board)
      game_scores[detect_winner(board)] += 1
      display_scores(game_scores)
      prompt "#{detect_winner(board)} won!"
    else
      prompt "It's a tie!"
    end
  
    if grand_winner? game_scores
      winner = game_scores.key(5)
      prompt "#{winner} is the grand winner!"
    end
  
    prompt 'Play again? (y or n)'
    answer = gets.chomp
    break if grand_winner?(game_scores) && answer.downcase.start_with?('y')
    if answer.downcase.start_with?('y') == false
      continue = false
      break
    end
    next if answer.downcase.start_with?('y')
  end

  break if continue == false
end 

prompt 'Thanks for playing TTT! Bye.'
