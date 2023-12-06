times = []
distances = []
result = 1

File.readlines('6-1').each do |line|
  times = line.split(':')[1].split(' ') if line.include?('Time')
  distances = line.split(':')[1].split(' ') if line.include?('Distance')
end

p times
p distances

times.each_with_index do |time, i|
  num_sol = 0
  (1..time.to_i).each do |attempt|
    reach = attempt * (time.to_i - attempt)
    num_sol += 1 if reach > distances[i].to_i
  end

  result *= num_sol
end

p result
