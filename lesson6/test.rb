def scores
  score = [10]
  puts "Score is #{score.first}"
  score.first += 1
  puts "Score + 1 is #{score.first}"
  score.clone
end

scores
scores

puts scores