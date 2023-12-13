require 'matrix'

def validate_list(springs, arrange)
  in_serie = false
  arrange_i = 0
  count_faulty = 0

  springs.each do |spring|
    if spring == "." && in_serie
      in_serie = false
      if count_faulty != arrange[arrange_i]
        return false
      else
        count_faulty = 0
        arrange_i += 1
      end
    end

    if spring == "#"
      count_faulty += 1
      in_serie = true
    end
  end

  if in_serie
    in_serie = false
    if count_faulty != arrange[arrange_i]
      return false
    else
      count_faulty = 0
      arrange_i += 1
    end
  end

  return arrange_i == arrange.length
end


def find_unknown_springs(springs, arrange, unknown, i)
  with_bad = springs.map(&:clone)
  with_good = springs.map(&:clone)
  count = 0

  with_bad[unknown[i]] = "#"
  with_good[unknown[i]] = "."

  if i != unknown.length - 1
    count += find_unknown_springs(with_bad, arrange, unknown, i+1)
    count += find_unknown_springs(with_good, arrange, unknown, i+1)
  else
    count += 1 if validate_list(with_bad, arrange)
    count += 1 if validate_list(with_good, arrange)
    return count
  end

  return count
end

sum = 0
i = 0

File.readlines(File.join(__dir__, '12-1')).each do |line|
  springs = line.split(" ")[0].split("")
  arrange = line.chomp.split(" ")[1].split(",").map(&:to_i)

  unknown = springs.each_with_index.filter_map { |char, index| char == '?' ? index : nil }
  sum += find_unknown_springs(springs, arrange, unknown, 0)
  i +=1
end

p sum
