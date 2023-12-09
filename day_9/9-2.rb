lines = []
sum = 0

File.readlines(File.join(__dir__, '9-2')).each do |line|
  lines << line.delete("\n").split(" ").map(&:to_i)
end


lines.each do |line|
  diffs = [line]
  while true
    diffs << diffs.last.each_cons(2).map { |a, b| b - a }
    break if diffs.last.all? {|i| i.zero?}
  end
  extrapolated = []
  i = diffs.length - 1
  diffs.reverse_each do |diff|
    extrapolated[i] = diff
    extrapolated[i].unshift diff.first -  extrapolated[i + 1].first if i != diffs.length - 1

    i -= 1
  end

  sum += extrapolated[0].first
  p sum
end
