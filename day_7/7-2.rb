
def get_hand_score(hand, bids, index)
  return { i: index, bid: bids[index], val: 6, hand: hand } if hand.chars.uniq.length == 1

  cards = {}
  hand.each_char do |card|
    cards[card] = cards[card].nil? ? 1 : cards[card] + 1
  end

  joker_count = cards["J"].nil? ? 0 : cards["J"]

  pair_count = 0
  triple_count = 0
  cards.each do |card, qt|
    next if card == "J"
    return { i: index, bid: bids[index], val: 6, hand: hand } if qt + joker_count == 5
    return { i: index, bid: bids[index], val: 5, hand: hand } if qt + joker_count == 4

    pair_count += 1 if qt == 2
    triple_count += 3 if qt == 3
  end

  return { i: index, bid: bids[index], val: 4, hand: hand } if pair_count == 2 and joker_count == 1
  return { i: index, bid: bids[index], val: 3, hand: hand } if pair_count == 1 and joker_count == 1
  return { i: index, bid: bids[index], val: 3, hand: hand } if pair_count == 0 and joker_count == 2
  return { i: index, bid: bids[index], val: 1, hand: hand } if pair_count == 0 and joker_count == 1

  { i: index, bid: bids[index], val: pair_count + triple_count, hand: hand }
end

def order_hands(hands)
  priority_map = { "A" => 13, "K" => 12, "Q" => 11, "J" => 0, "T" => 9, "9" => 8, "8" => 7, "7" => 6, "6" => 5, "5" => 4, "4" => 3, "3" => 2, "2" => 1 }

  hands.sort_by do |obj|
    [
      obj[:val],
      priority_map[obj[:hand][0]],
      priority_map[obj[:hand][1]],
      priority_map[obj[:hand][2]],
      priority_map[obj[:hand][3]],
      priority_map[obj[:hand][4]]
    ]
  end
end

hands = []
bids = []

File.readlines('7-2').each do |line|
  hands << line.split(' ')[0]
  bids << line.split(' ')[1].to_i
end


scores = []
hands.each_with_index do |hand, i|
  scores << get_hand_score(hand, bids, i)
end

scores = order_hands(scores)

result = scores.each_with_index.reduce(0) do |sum, (hand, index)|
  sum + hand[:bid] * (index + 1)
end

p result
