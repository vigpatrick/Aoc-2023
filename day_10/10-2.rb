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
    return true
  else
    return possible_junction[current_pipe.to_sym].include?(next_pipe)
  end
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
  visited << "#{pos[0]},#{pos[1]}"

  while current_pipe != "S"
    dir = possible_dir[current_pipe.to_sym].filter {|new_dir| new_dir + dir != Vector[0,0]}[0]
    current_pipe =  map[pos[1] + dir[1]][pos[0]+ dir[0]]
    pos = [pos[0] + dir[0], pos[1] + dir[1]]
    visited << "#{pos[0]},#{pos[1]}"

    return if current_pipe == '.'
    count += 1
  end


  p count % 2 == 0 ? count / 2 : (count - 1)  / 2

  visited
end

map = []
i = 0
start = []
visited = []

File.readlines(File.join(__dir__, '10-2')).each do |line|
  map << line.delete("\n").split("")

  start = Vector[line.index("S"), i] if line.include?("S")
  i += 1
end


possible_dir = [Vector[1,0], Vector[-1, 0], Vector[0, 1], Vector[0,-1]]

starts = []
possible_dir.each do | dir |
  next unless possible_dir(map, dir, start)
  starts << dir
  visited << follow_path(start, map, dir)
end


(0..map.length-1).each do |j|
  (0..map[0].length-1).each do |i|
      map[j][i] = "." unless visited[0].include?("#{i},#{j}")
      map[j][i] = "J" if map[j][i] == "S"
  end
end

count = 0

(0..map.length-1).each do |j|
  outside = true
  (0..map[0].length-1).each do |i|
    if ["|", "J", "L"].include?(map[j][i])
      outside = !outside
    end

    count += 1 if !outside && map[j][i] == "."
  end
  p count
end
