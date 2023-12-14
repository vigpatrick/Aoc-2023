require 'matrix'

map = []
sum = 0


File.readlines(File.join(__dir__, '14-1')).each do |line|
  map << line.chomp.split("")
end

(0..120).each do |x|
  map.each_with_index do |m, i|
    next if i == 0

    indices = m.each_with_index.filter_map { |char, index| char == 'O' ? index : nil }

    indices.each do |j|
      if map[i - 1][j] == '.'
        map[i - 1][j] = 'O'
        map[i][j] = '.'
      end
    end
  end
end

map.each_with_index do |m, i|
  p m.join("") + (map.length - i).to_s
  sum += (map.length - i) *  m.each_with_index.filter_map { |char, index| char == 'O' ? index : nil }.length
end

p sum
