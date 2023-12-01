result = 0

File.readlines('Day-1-1').each do |line|
  first_digit = line.match(/\d/)
  last_digit = line.reverse.match(/\d/)

  p (first_digit[0].to_i * 10) + last_digit[0].to_i
  result += (first_digit[0].to_i * 10) + last_digit[0].to_i
end

p result
