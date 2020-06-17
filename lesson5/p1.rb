arr = ['10', '11', '9', '7', '8']

arr_sorted = arr.sort{ |a, b| b.to_i <=> a.to_i }
puts arr_sorted