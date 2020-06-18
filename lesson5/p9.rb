arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

=begin
result = arr.each_with_object([]) do |el, new_arr|
  new_arr << el.sort do |a, b|
    b <=> a
  end
=end

result = arr.map{ |sub_arr| sub_arr.sort{ |a, b| b <=> a } }

puts arr.inspect
puts result.inspect