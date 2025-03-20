class YahtzeeScoring
  attr_reader :roll, :tally, :best_score, :best_category

  STRAIGHTS = {
    small: [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]],
    large: [[1, 2, 3, 4, 5], [2, 3, 4, 5, 6]]
  }

  def initialize(roll)
    @roll = roll
    @tally = roll.tally
    @roll_total = roll.sum
    @unique_sorted = @tally.keys.sort

    @best_score = 0
    @best_category = nil
  end
  
  def self.best_score(roll)
    new(roll).score_lower_section(roll)
  end

  def score_upper_section(roll)
    best_category = nil
    best_score = 0

    (1..6).each do |num|
      score = roll.count(num) * num
      if score > best_score
        best_score = score
        best_category = num_to_category(num)
      end
    end
    { category: best_category, score: best_score }
  end

  def num_to_category(num)
    { 1 => :ones, 2 => :twos, 3 => :threes, 4 => :fours, 5 => :fives, 6 => :sixes }[num]
  end

  def score_lower_section(roll)
    return score_yahtzee if yahtzee?
    return score_large_straight if large_straight?

    categories = [
      score_three_of_a_kind(roll),
      score_four_of_a_kind(roll),
      score_full_house(roll),
      score_small_straight(roll),
      score_chance(roll),
      score_upper_section(roll)
    ].max_by { |hash| hash[:score] }
  end

  def score_three_of_a_kind(roll)
    roll.each do |num|
      return { category: :three_of_a_kind, score: roll.sum } if roll.count(num) >= 3
    end
    { category: nil, score: 0 }
  end

  def yahtzee?
    @tally.size == 1
  end

  def score_yahtzee
    update_score(:yahtzee, 50)
    high_score
  end

  def large_straight?
    return unless @tally.size == 5
    STRAIGHTS[:large].include?(@unique_sorted)
  end

  def score_large_straight
    update_score(:large_straight, 40)
    high_score
  end 

  def score_four_of_a_kind(roll)
    roll.each do |num|
      return { category: :four_of_a_kind, score: roll.sum } if roll.count(num) >= 4
    end
    { category: nil, score: 0 }
  end

  def score_full_house(roll)
    counts = roll.tally.values.sort
    return { category: :full_house, score: 25 } if counts == [2, 3]
    { category: nil, score: 0 }
  end

  def score_small_straight(roll)
    unique_sorted = roll.uniq.sort
    straights = [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]]
    return { category: :small_straight, score: 30 } if straights.any? { |s| (s - unique_sorted).empty? }
    { category: nil, score: 0 }
  end

  def score_chance(roll)
    { category: :chance, score: roll.sum }
  end

  def update_score(category, score)
    return if score <= @best_score

    @best_score = score
    @best_category = category
  end

  def high_score
    { category: @best_category, score: @best_score }
  end
end
