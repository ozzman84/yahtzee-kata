class FullHouse
  def self.score(roll)
    { category: :full_house, score: 25 } if roll.sorted_tallies == [2, 3] && 25 >= roll.total
  end
end