time = 0
distance = 0

File.readlines('6-2').each do |line|
  time = line.split(':')[1].delete(' ').strip if line.include?('Time')
  distance = line.split(':')[1].delete(' ').strip if line.include?('Distance')
end

p time
p distance

num_sol = 0
(1..time.to_i).each do |attempt|
  reach = attempt * (time.to_i - attempt)
  num_sol += 1 if reach > distance.to_i
end

p num_sol
