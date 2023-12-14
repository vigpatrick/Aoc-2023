require 'matrix'

current_pattern = []
sum = 0
i = 0

def check_for_following_rows(pattern, start)
  good = true
  smudge = pattern[start[0]].zip(pattern[start[1]]).count { |a, b| a != b }

  rows = start + Vector[-1,1]
  while true
    break if rows[0] < 0 || rows[1] == pattern.length

    if pattern[rows[0]] != pattern[rows[1]]
      if smudge == 1
        good = false
        break
      end

      if pattern[rows[0]].zip(pattern[rows[1]]).count { |a, b| a != b } == 1
        smudge = 1
      else
        good = false
        break
      end
    end

    rows += Vector[-1,1]
  end
  good && smudge == 1
end

def find_mirror(pattern, mult)
  current_position = Vector[0,1]

  while current_position[1] != pattern.length
    if pattern[current_position[0]] != pattern[current_position[1]] && pattern[current_position[0]].zip(pattern[current_position[1]]).count { |a, b| a != b } != 1
      current_position += Vector[1,1]
    else
      return (current_position[0] + 1) * mult if check_for_following_rows(pattern, current_position)
      current_position += Vector[1,1]
    end
  end
  0
end

File.readlines(File.join(__dir__, '13-2')).each do |line|
  if line.chomp != ""
    current_pattern << line.chomp.split("")
  else
    p "pattern : #{i}"
    sum += find_mirror(current_pattern.transpose, 1)
    sum += find_mirror(current_pattern, 100)

    current_pattern = []
    i +=1
  end
end

p sum
