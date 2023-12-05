def map_value(maps, value, key)
  map = maps[key]
  int_val = value.to_i

  map.each do |range|
    if int_val >= range[1].to_i && int_val <= range[1].to_i + range[2].to_i
      offset = int_val - range[1].to_i
      return range[0].to_i + offset
    end
  end

  value
end

seeds = []
current_value_processed = []
maps = {}

order = %w[seed soil fertilizer water light temperature humidity location]

current_map = ''
File.readlines('5-1').each do |line|
  if line.include?('seeds')
    seeds = line.split(':')[1].split(' ')
    next
  end

  next if line.squeeze(' ') == "\n"

  if line.include?('map')
    current_map = line.split(' ')[0]
    maps[current_map] = []
    next
  end

  maps[current_map] << line.split(' ')
end

current_value_processed = seeds

seeds.each_with_index do |_seed, index|
  order.each_with_index do |step, step_index|
    next if step == 'location'

    key = "#{step}-to-#{order[step_index + 1]}"
    current_value_processed[index] = map_value(maps, current_value_processed[index], key)
  end
end

p "min: #{current_value_processed.min}"
