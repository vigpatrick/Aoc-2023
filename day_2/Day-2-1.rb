result = 0

# 12 red cubes, 13 green cubes, and 14 blue cubes
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

bag = {
  red: 12,
  green: 13,
  blue: 14
}

File.readlines('Day-2-1').each do |line|
  valid = true
  id = line.split(':')[0].split(' ')[1].to_i

  games = line.split(':')[1].split(';')

  games.each do |game|
    blocks = game.delete('\n').split(',')

    blocks.each do |block|
      if block.split(' ')[0].to_i > bag[block.split(' ')[1].strip.to_sym]
        valid = false
        break
      end
      break unless valid
    end
  end

  result += id if valid
end

p result
