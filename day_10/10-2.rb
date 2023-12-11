require 'matrix'

def possible_dir(map, direction, current_pipe_pos)

  possible_junction = {
    "-": ["7", "-", "F", "J", "L"],
    "7": ["|", "-", "F", "J", "L"],
    "F": ["7", "-", "|", "J", "L"],
    "J": ["7", "-", "F", "|", "L"],
    "L": ["7", "-", "F", "J", "|"],
    "|": ["7", "|", "F", "J", "L"],
  }

  next_y = current_pipe_pos[1] + direction[1]
  next_x = current_pipe_pos[0] + direction[0]
  return false if next_y < 0 ||  next_y >= map.length
  return false if next_x < 0 ||  next_x >= map[0].length

  next_pipe = map[next_y][next_x]
  current_pipe = map[current_pipe_pos[1]][current_pipe_pos[0]]
  return false if next_pipe == "."

  if current_pipe == "S"
    return false if direction[1] == 1 && ["J", "L", "-"].include?(next_pipe)
    return false if direction[1] == -1 && ["7", "F", "-"].include?(next_pipe)
    return false if direction[0] == 1 && ["L", "F", "|"].include?(next_pipe)
    return false if direction[0] == -1 && ["7", "J", "|"].include?(next_pipe)
  end

  return true
end

def follow_path(start, map, dir)
  visited = []
  possible_dir = {
    "-": [Vector[-1, 0], Vector[1, 0]],
    "7": [Vector[-1, 0], Vector[0, 1]],
    "F": [Vector[1, 0], Vector[0, 1]],
    "J": [Vector[-1, 0], Vector[0, -1]],
    "L": [Vector[1, 0], Vector[0, -1]],
    "|": [Vector[0, -1], Vector[0, 1]],
  }

  current_pipe = map[start[1] + dir[1]][start[0] + dir[0]]
  pos = [start[0] + dir[0], start[1] + dir[1]]
  count = 1
  visited << pos.dup

  while current_pipe != "S"
    dir = possible_dir[current_pipe.to_sym].filter { |new_dir| new_dir + dir != Vector[0, 0] }[0]
    current_pipe = map[pos[1] + dir[1]][pos[0] + dir[0]]
    pos = [pos[0] + dir[0], pos[1] + dir[1]]
    visited << pos.dup

    return visited if current_pipe == '.'
    count += 1
  end

  p count.even? ? count / 2 : (count - 1) / 2
  visited
end

map = []
start = []

File.readlines(File.join(__dir__, '10-2')).each.with_index do |line, i|
  map << line.chomp.split("")
  start = Vector[line.index("S"), i] if line.include?("S")
end

possible_dir = [Vector[1, 0], Vector[-1, 0], Vector[0, 1], Vector[0, -1]]

starts = possible_dir.select { |dir| possible_dir(map, dir, start) }
visited = starts.map { |dir| follow_path(start, map, dir) }.flatten(1)

map.each_index do |j|
  map[0].each_index do |i|
    map[j][i] = "." unless visited.include?([i, j])
    map[j][i] = "J" if map[j][i] == "S"
  end
end

count = 0

map.each_index do |j|
  outside = true
  map[0].each_index do |i|
    if ["|", "J", "L"].include?(map[j][i])
      outside = !outside
    end

    count += 1 if !outside && map[j][i] == "."
  end
  p count
end
