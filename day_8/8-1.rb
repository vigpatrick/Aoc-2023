instructions = ""
map = {}

File.readlines('8-1').each do |line|
  if instructions == ""
    instructions = line.delete("\n")
    next
  end
  next if line == "\n"
  p line
  l = line.split('=')[1].split(',')[0].delete('(').strip
  r = line.split('=')[1].split(',')[1].delete(")\n").strip
  map[line.split('=')[0].strip] = { L: l, R: r }
end
p map
steps = 0
zzz_found = false
current_node = "AAA"

until zzz_found do
  instructions.chars.each do |instruction|
    p current_node
    p instruction
    current_node = map[current_node][instruction.to_sym]
    steps += 1
    if current_node == "ZZZ"
      zzz_found = true
      break
    end
  end
end

p steps
