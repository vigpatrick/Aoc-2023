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
  possible_dir = {
    "-": [Vector[-1, 0], Vector[1, 0]],
    "7": [Vector[-1, 0], Vector[0, 1]],
    "F": [Vector[1, 0], Vector[0, 1]],
    "J": [Vector[-1, 0], Vector[0, -1]],
    "L": [Vector[1, 0], Vector[0, -1]],
    "|": [Vector[0, -1], Vector[0, 1]],
  }

  current_pipe = map[start[1] + dir[1]][start[0] + dir[0]]
  pos = start + dir
  count = 1

  while current_pipe != "S"
    dir = possible_dir[current_pipe.to_sym].filter { |new_dir| new_dir + dir != Vector[0, 0] }[0]
    current_pipe = map[pos[1] + dir[1]][pos[0] + dir[0]]
    pos += dir

    break if current_pipe == '.'
    count += 1
  end

  p count.even? ? count / 2 : (count - 1) / 2
end

map = File.readlines(File.join(__dir__, '10-1')).map { |line| line.chomp.split('') }
start = map.each_with_index.flat_map { |line, i| line.include?('S') ? Vector[line.index('S'), i] : [] }.first

possible_dir = [Vector[1, 0], Vector[-1, 0], Vector[0, 1], Vector[0, -1]]
starts = possible_dir.filter { |dir| possible_dir(map, dir, start) }
starts.each { |dir| follow_path(start, map, dir) }
