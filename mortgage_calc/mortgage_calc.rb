def valid_input?(entry)
  entry != nil && (entry.to_i.to_s == entry || entry.to_f.to_s == entry) && entry.to_f > 0
end

loop do
  loan_amount = nil
  apr = nil
  years = nil

  loop do
    puts '>> Welcome to mortgage calculator!  Enter the total loan amount:'
    loan_amount = gets.chomp
    if valid_input?(loan_amount) == false
      puts '>> Loan amount is invalid, try again.'
      next
    end

    break
  end

  loop do
    puts '>> Enter the annual percentage rate, without the "%" sign.'
    puts '>> (ex: Enter "5.4" for 5.4%):'
    apr = gets.chomp
    if valid_input?(apr) == false
      puts '>> APR is invalid, try again.'
      next
    end

    break
  end

  loop do
    puts '>> Finally, enter the loan duration in years:'
    years = gets.chomp
    if valid_input?(years) == false
      puts '>> Number of years is invalid, try again.'
      next
    end

    break
  end

  p = loan_amount.to_f
  j = (apr.to_f / 100) / 12
  n = years.to_f * 12
  m = p * (j / (1 - (1 + j)**(-n)))

  puts ">> Your monthly payment is $#{m.round(2)}."
  puts ">> Your monthly interest rate is #{j.round(3)}%."
  puts ">> Your loan duration in months is #{n}."

  puts '>> Perform another calculation? Enter "y" for "yes", or "q" to quit.'
  response = gets.chomp
  next if response.downcase.start_with? 'y'
  if response.downcase.start_with? 'q'
    puts '>> Thanks for using!'
    break
  end
end
