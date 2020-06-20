def generate_uuid
  hex_characters = (0..9).to_a.map(&:to_s).concat(('a'..'f').to_a)
  lengths = [8, 4, 4, 4, 12]
  lengths.map! do |multiple|
    sub_str = ''
    multiple.times do
      random_hex_char = hex_characters.sample # select a new hex char each time
      sub_str << random_hex_char
    end
    sub_str
  end
  lengths.join('-')
end

puts generate_uuid

 