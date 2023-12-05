def normalize_range(range)
  range.begin <= range.end ? range : (range.end..range.begin)
end

def subtract_ranges(original_range, list_of_ranges)
  result_ranges = [original_range]

  list_of_ranges.each do |range|
    result_ranges = result_ranges.flat_map do |result_range|
      subtract_range(result_range, normalize_range(range))
    end
  end

  result_ranges.compact
end

def subtract_range(original_range, subtracted_range)
  return nil if original_range.nil?

  if subtracted_range.end < original_range.begin || subtracted_range.begin > original_range.end
    original_range  # No overlap, return the original range
  else
    # Overlap, subtract the overlapping part
    [
      (original_range.begin..[original_range.end, subtracted_range.begin - 1].min),
      ([original_range.begin, subtracted_range.end + 1].max..original_range.end)
    ].reject { |range| range.begin > range.end }  # Remove invalid ranges
  end
end

def parse_map(maps, ranges, key)
  out_ranges = []
  map = maps[key]

  ranges.each do |in_range|
    range1 = (in_range[0].to_i..in_range[1].to_i)
    parsed_ranges = []
    map.each do |range|
      range_min = range[1].to_i
      range_max = range[1].to_i + range[2].to_i
      range2 = (range_min..range_max)

      common_range = range1.end < range2.begin || range2.end < range1.begin ? nil : [range1.begin, range2.begin].max..[range1.end, range2.end].min

      if common_range != nil
        parsed_ranges << common_range
        min = range[0].to_i + common_range.begin - range[1].to_i
        max = range[0].to_i + common_range.end - range[1].to_i
        out_ranges << [min, max]
      end
    end

    subtract_ranges(range1, parsed_ranges).each do |to_add|
      out_ranges << [to_add.begin, to_add.end]
    end
  end

  out_ranges
end

seeds = []
current_value_processed = []
maps = {}

order = %w[seed soil fertilizer water light temperature humidity location]

current_map = ''
File.readlines('5-2').each do |line|
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

current_value_processed = []

seeds.each_slice(2).to_a.each do |range|
  current_value_processed << [range[0].to_i, range[0].to_i + range[1].to_i]
end

order.each_with_index do |step, step_index|
  next if step == 'location'

  key = "#{step}-to-#{order[step_index + 1]}"
  current_value_processed = parse_map(maps, current_value_processed, key)
end

result_array = []

current_value_processed.each do |range|
  result_array << range[0]
  result_array << range[1]
end

p "min: #{result_array.min}"
