def scan_numbers_with_indices(input_string)
  regex_pattern = /\d+/

  matches = input_string.scan(regex_pattern)

  offset = 0
  matches.map do |number|
    index = input_string.index(number, offset)
    offset = index + number.length
    {
      number: number,
      index: index
    }
  end
end

def scan_asterix_with_indices(input_string)
  regex_pattern = /\*/

  matches = input_string.scan(regex_pattern)

  offset = 0
  matches.map do |gear|
    index = input_string.index(gear, offset)
    offset = index + 1
    {
      gear: gear,
      index: index
    }
  end
end

def compute_row(row_nums, nums, gear_index)
  row_nums.each do |num_i|
    index = num_i[:index]
    num = num_i[:number]

    if index + num.length > gear_index - 1 && index <= gear_index + 1
      nums << num
      return nums if nums.length == 2
    end
  end

  nums
end

def compute_line(prev, current, after)
  line_sum = 0
  nums_before = scan_numbers_with_indices(prev) if prev != ''
  nums_current = scan_numbers_with_indices(current)
  nums_after = scan_numbers_with_indices(after) if after != ''

  rows = [nums_before, nums_current, nums_after]

  gears = scan_asterix_with_indices(current)

  gears.each do |obj|
    gear_i = obj[:index]
    nums = []

    rows.each do |row_nums|
      next if row_nums.nil?
      nums = compute_row(row_nums, nums, gear_i)
      if nums.length == 2
        line_sum += nums[0].to_i * nums[1].to_i
        break
      end
    end
  end

  line_sum
end

result = 0

previous_line = ''
current_line = ''
last_line = ''

File.readlines('3-2').each do |next_line|
  if previous_line == ''
    previous_line = next_line
  elsif current_line == ''
    result += compute_line('', previous_line, next_line)
    current_line = next_line
  else
    result += compute_line(previous_line, current_line, next_line)
    previous_line = current_line
    current_line  = next_line
  end
  last_line = next_line
end
result += compute_line(previous_line, last_line, '')

p result
