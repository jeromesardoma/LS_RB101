arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

result = arr.map do |sub_arr|
  sub_arr.reject{ |e| e % 3 != 0 }
end

puts arr.inspect
puts result.inspect