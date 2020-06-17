arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
puts arr1.last.last.last == 'g'

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
puts arr2.last[:third].first == 'g'

arr3 = [['abc'], ['def'], {third: ['ghi']}]
puts arr3.last[:third][0][0] == 'g'

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
puts hsh1['b'].last == 'g'

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
puts hsh2[:third].keys[0] == 'g'