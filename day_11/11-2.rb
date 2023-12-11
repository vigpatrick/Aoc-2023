require 'matrix'

map = []
galexies = []
empty_rows = []
empty_cols = []
i = 0
distances = {}

File.readlines(File.join(__dir__, '11-1')).each do |line|
  map << line.chomp.split("")
  indices = line.each_char.with_index.filter_map { |char, index| char == '#' ? index : nil }
  empty_rows << i if indices.empty?
  indices.each do |indice|
    galexies << [indice, i]
  end
  i += 1
end

map[0].each_index do |x|
  empty = true
  map.each_index do |y|
    if map[y][x] == "#"
      empty = false
    end
  end

  empty_cols << x if empty
end

galexies.each_with_index do |start, s|
  galexies.each_with_index do |goal, g|
    next if start == goal
    next unless distances["#{g}-#{s}"].nil?
    distances["#{s}-#{g}"] = (start[0] - goal[0]).abs + (start[1] - goal[1]).abs

    empty_rows.each do |row|
      distances["#{s}-#{g}"] += 1 if row.between?(start[1], goal[1]) || row.between?(goal[1], start[1])
    end

    empty_cols.each do |col|
      distances["#{s}-#{g}"] += 1 if col.between?(start[0], goal[0]) || col.between?(goal[0], start[0])
    end
  end
end

p distances.values.sum

