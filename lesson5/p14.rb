hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

result = hsh.each_with_object([]) do |(_, details), new_arr|
  if details[:type] == 'fruit'
    new_arr << details[:colors].map(&:capitalize)
  else
    new_arr << details[:size].upcase
  end
end

puts hsh.inspect
puts result.inspect