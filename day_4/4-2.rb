cards_qt = []

File.readlines('4-2').each do |card|
  card_score = 0
  card_id = card.split('|')[0].split(':')[0].split(' ')[1].to_i - 1
  winning_nums = card.split('|')[0].split(':')[1].split(' ')
  my_nums = card.split('|')[1].split(' ')

  cards_qt[card_id] = cards_qt[card_id].nil? ? 1 : cards_qt[card_id] + 1

  winning_nums.each do |num|
    if my_nums.include?(num)
      card_score += 1
      cards_qt[card_id + card_score] = cards_qt[card_id + card_score].nil? ? cards_qt[card_id] : cards_qt[card_id + card_score] + cards_qt[card_id]
    end
  end
end

p cards_qt.reduce(:+)
