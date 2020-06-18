hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.values.each do |arr|
  arr.each do |str|
    puts str.delete('^aeiou')
  end
end