result = 0

File.readlines('4-1').each do |card|
  card_score = 0
  winning_nums = card.split('|')[0].split(':')[1].split(' ')
  my_nums = card.split('|')[1].split(' ')

  winning_nums.each do |num|
    if my_nums.include?(num)
      card_score = card_score.zero? ? 1 : card_score * 2
    end
  end
  result += card_score
end

p result
