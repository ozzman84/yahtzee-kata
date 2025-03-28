class Straight
  STRAIGHTS = {
    small: [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]],
    large: [[1, 2, 3, 4, 5], [2, 3, 4, 5, 6]]
  }

  def self.score(roll)
    case roll.unique_sorted.size
    when 5
      { category: :large_straight, score: 40 } if STRAIGHTS[:large].include?(roll.unique_sorted)
    when 4
      { category: :small_straight, score: 30 } if STRAIGHTS[:small].include?(roll.unique_sorted)
    end
  end
end