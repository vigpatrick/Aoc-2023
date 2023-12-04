def look_for_symbol_in_range(string, start_index, end_index)
  regex_pattern = /[^a-zA-Z0-9.]/

  start_index = 0 if start_index < 0
  index = string.index(regex_pattern, start_index)

  while index && index <= end_index
    return index if string[index] =~ regex_pattern

    # Continue searching for the next occurrence
    index += 1

    # Find the next occurrence of a non-alphanumeric character or dot
    index = string.index(regex_pattern, index)
  end

  nil
end

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

def compute_line(prev, current, after)
  line_sum = 0
  nums = scan_numbers_with_indices(current)

  nums.each do |obj|
    num = obj[:number]
    index = obj[:index]

    if prev != '' && look_for_symbol_in_range(prev.delete("\n"), index - 1, index + num.length) != nil
      line_sum += num.to_i
      next
    end

    if look_for_symbol_in_range(current.delete("\n"), index - 1, index + num.length) != nil
      line_sum += num.to_i
      next
    end

    if after != '' && look_for_symbol_in_range(after.delete("\n"), index - 1, index + num.length) != nil
      line_sum += num.to_i
      next
    end
  end

  line_sum
end

result = 0

previous_line = ''
current_line = ''
last_line = ''

File.readlines('3-1').each do |next_line|
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
