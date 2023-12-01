result = 0

nums = %w[one two three four five six seven eight nine]

File.readlines('Day-1-2').each do |line|
  vals = []
  first_digit = line.match(/\d/)
  vals[first_digit.begin(0)] = first_digit[0].to_i if first_digit

  last_digit = line.reverse.match(/\d/)
  vals[line.rindex(last_digit[0])] = last_digit[0].to_i if last_digit

  nums.each_with_index do |num, i|
    index = line.index(num)

    while index
      vals[index] = i + 1
      index = line.index(num, index + 1)
    end
  end

  vals = vals.compact

  result += (vals.first * 10) + vals.last
end


p result
