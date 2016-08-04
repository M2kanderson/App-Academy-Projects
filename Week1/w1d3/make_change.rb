def make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  return nil if coins.none? {|coin| coin <= amount}
  possibilities = []

  combo = []
  counts = coins.sort.reverse
  coins.each do |coin|
    next if coin > amount
    remainder = amount - coin
    best_remainder = make_change(remainder, coins)
    next if best_remainder.nil?
    combo = [coin] + best_remainder
    possibilities << combo
  end


  possibilities = possibilities.min_by{|poss| poss.length}

end




p make_change(24,[10,7,1])
