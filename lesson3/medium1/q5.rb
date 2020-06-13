limit = 15

def fib(first_num, second_num, upper_bound)
  while first_num + second_num < upper_bound
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"