result = 0

# 12 red cubes, 13 green cubes, and 14 blue cubes
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

File.readlines('Day-2-2').each do |line|
  max_bag = {
    red: 0,
    green: 0,
    blue: 0
  }
  games = line.split(':')[1].split(';')

  games.each do |game|
    blocks = game.delete("\n").split(',')

    blocks.each do |block|
      num = block.split(' ')[0].to_i
      color = block.split(' ')[1].strip

      max_bag[color.to_sym] = num if num > max_bag[color.to_sym]
    end
  end

  result += max_bag.reduce(1) { |product, num| num[1] * product }
end

p result
