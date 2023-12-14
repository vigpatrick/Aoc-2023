require 'matrix'

map = []
sum = 0
sums = {}

File.readlines(File.join(__dir__, '14-2')).each do |line|
  map << line.chomp.split("")
end

duplicate = map.map{|m| m}

(0..1999).each do |ite|
  (0..100).each do |x|
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
  map = map.transpose.map(&:reverse)

  if (ite + 1) % 4 == 0
    sum = 0
    map.each_with_index do |m, h|
      sum += (map.length - h) *  m.each_with_index.filter_map { |char, index| char == 'O' ? index : nil }.length
    end

    if sums[sum].nil?
      sums[sum] = [(ite + 1) / 4]
    else
      sums[sum] << (ite + 1) / 4
    end

    p (ite + 1) / 4
  end
end

sum = 0
map.each_with_index do |m, i|
  p m.join("") + (map.length - i).to_s
  sum += (map.length - i) *  m.each_with_index.filter_map { |char, index| char == 'O' ? index : nil }.length
end

p sum

sums.each do |k, v|
  p "#{k} - #{v} - #{v[1] - v[0]}"   if v.length > 2
end
