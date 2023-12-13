def count_arrangements(chars, springs)
  n = chars.length
  m = springs.length
  dp = Array.new(n + 1) { Array.new(m + 1, 0) }
  dp[n][m] = 1

  (n - 1).downto(0) do |i|
    (m - 1).downto(0) do |j|
      damaged = false
      operational = false

      case chars[i]
      when '#'
        damaged = true
      when '.'
        operational = true
      else
        operational = true
        damaged = true
      end

      sum = 0

      if damaged && springs[j]
        sum += dp[i + 1][j + 1]
      elsif operational && !springs[j]
        sum += dp[i + 1][j + 1] + dp[i + 1][j]
      end

      dp[i][j] = sum
    end
  end

  dp[0][0]
end



sum = 0
i = 0

File.readlines(File.join(__dir__, '12-2')).each do |line|
  springs = line.split(" ")[0].split("")
  arrange = line.chomp.split(" ")[1].split(",").map(&:to_i) * 5
  springs << "?"
  springs = springs * 5
  springs[springs.length - 1] = "."
  springs.unshift(".")

  damagedSprings = arrange.flat_map { |count| Array.new(count, true) + [false] }
  damagedSprings.unshift(false)

  sum += count_arrangements(springs, damagedSprings)
end

p sum
