require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def is_integer?(string)
  string.to_i.to_s == string
end

def is_float?(string)
  string.to_f.to_s == string
end

def valid_number?(number_string)
  is_integer?(number_string) || is_float?(number_string)
end

loop do
  entry1 = nil
  entry2 = nil

  loop do
    prompt MESSAGES['welcome']
    entry1 = gets.chomp

    prompt MESSAGES['welcome2']
    entry2 = gets.chomp

    if [entry1, entry2].any? { |e| valid_number? e } == false
      prompt MESSAGES['invalid_entries']
      next
    end

    break
  end

  entry1 = entry1.to_f
  entry2 = entry2.to_f

  loop do
    operator_prompt = <<-MSG
    What operation would you like to perform?
      1) add
      2) subtract
      3) multiply
      4) divide
    MSG

    prompt operator_prompt
    operation = gets.chomp.to_i

    case operation
    when 1 then prompt "#{entry1} + #{entry2} = #{entry1 + entry2}"
    when 2 then prompt "#{entry1} - #{entry2} = #{entry1 - entry2}"
    when 3 then prompt "#{entry1} * #{entry2} = #{entry1 * entry2}"
    when 4 then prompt "#{entry1} / #{entry2} = #{entry1.to_f / entry2.to_f}"
    else
      prompt MESSAGES['invalid_operation']
      next
    end

    break
  end

  prompt MESSAGES['perform_again']
  response = gets.chomp
  next if response.downcase.start_with? 'y'
  if response.downcase.start_with? 'q'
    prompt MESSAGES['exit_message']
    break
  end
end
