require 'matrix'

current_pattern = []
sum = 0

def check_for_following_rows(pattern, start)
  good = true

  rows = start + Vector[-1,1]
  while true
    break if rows[0] < 0 || rows[1] == pattern.length

    if pattern[rows[0]] != pattern[rows[1]]
      good = false
      break
    end

    rows += Vector[-1,1]
  end
  good
end

def find_mirror(pattern, mult)
  current_position = Vector[0,1]

  while current_position[1] != pattern.length
    if pattern[current_position[0]] != pattern[current_position[1]]
      current_position += Vector[1,1]
    else
      return (current_position[0] + 1) * mult if check_for_following_rows(pattern, current_position)
      current_position += Vector[1,1]
    end
  end
  0
end

File.readlines(File.join(__dir__, '13-1')).each do |line|
  if line.chomp != ""
    current_pattern << line.chomp.split("")
  else
    sum += find_mirror(current_pattern.transpose, 1)
    sum += find_mirror(current_pattern, 100)

    current_pattern = []
  end
end

p sum
