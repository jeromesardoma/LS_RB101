def is_valid_number? number_string
  number_string.to_i.to_s == number_string
end

loop do

  puts "Welcome to calculator!  Enter a number, or 'q' to quit: "
  entry_1 = gets.chomp
  break if entry_1.downcase == 'q'

  puts "Enter the next number: "
  entry_2 = gets.chomp

  if [ entry_1, entry_2 ].any?{ |e| is_valid_number? e } == false 
    puts "You entered an invalid entry, try again."
    next
  end 

  entry_1 = entry_1.to_i
  entry_2 = entry_2.to_i

  puts "What operation would you like to perform? (add / subtract / multiply / divide )"
  operation = gets.chomp

  case operation
    when "add"      then puts "#{entry_1} + #{entry_2} = #{ entry_1 + entry_2 }"
    when "subtract" then puts "#{entry_1} - #{entry_2} = #{ entry_1 - entry_2 }"
    when "multiply" then puts "#{entry_1} * #{entry_2} = #{ entry_1 * entry_2 }"
    when "divide"   then puts "#{entry_1} / #{entry_2} = #{ entry_1.to_f / entry_2.to_f }"
    else                   puts "You entered an invalid operation, try again."
  end

end 
