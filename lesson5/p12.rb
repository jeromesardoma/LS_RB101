arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

result = arr.each_with_object({}) do |int_arr, new_hsh|
  new_hsh[int_arr[0]] = int_arr[1]
end

puts arr.inspect
puts result.inspect