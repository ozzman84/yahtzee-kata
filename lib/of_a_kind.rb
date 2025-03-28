class OfAKind
  def self.score(roll)
    case roll.max_tally
    when 5
      { category: :yahtzee, score: 50 }
    when 4
      { category: :four_of_a_kind, score: roll.total }
    when 3
      { category: :three_of_a_kind, score: roll.total }
    end
  end
end