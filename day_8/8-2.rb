def get_needed_steps(start, map, instructions)
  steps = 0

  until start.end_with?('Z')
    instructions.chars.each do |instruction|
      start =  map[start][instruction.to_sym]
      steps += 1

      break if start.end_with?('Z')
    end
  end

  steps
end

def find_lcm(steps)
  result = steps.reduce { |lcm, num| lcm.lcm(num) }

  result
end

instructions = ''
map = {}
starts = []

File.readlines('8-2').each do |line|
  if instructions == ''
    instructions = line.delete("\n")
    next
  end
  next if line == "\n"
  node = line.split('=')[0].strip
  l = line.split('=')[1].split(',')[0].delete('(').strip
  r = line.split('=')[1].split(',')[1].delete(")\n").strip
  map[node] = { L: l, R: r }

  starts << node if node[2] == 'A'
end

needed_steps = []

starts.each do |start|
  needed_steps << get_needed_steps(start, map, instructions)
end

p needed_steps
p find_lcm(needed_steps)
