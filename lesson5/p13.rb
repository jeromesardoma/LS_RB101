arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

result = arr.sort_by do |int_arr|
  int_arr.select(&:odd?)
end

puts arr.inspect
puts result.inspect