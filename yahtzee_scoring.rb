class YahtzeeScoring
  attr_reader :roll, :tally, :best_score, :best_category

  NUM_TO_CATEGORY = [:zero, :one, :two, :three, :four, :five, :six]
  STRAIGHTS = {
    small: [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]],
    large: [[1, 2, 3, 4, 5], [2, 3, 4, 5, 6]]
  }

  def initialize(roll)
    @roll = roll
    @tally = roll.tally
    @roll_total = roll.sum
    @unique_sorted = @tally.keys.sort
    @sorted_tallies = @tally.values.sort
    @max_tally = @sorted_tallies.last

    @best_score = 0
    @best_category = nil
  end
  
  def self.best_score(roll)
    new(roll).score_lower_section
  end

  def score_lower_section
    return score_yahtzee if yahtzee?
    return score_large_straight if large_straight?
    return score_small_straight if small_straight?

    update_score(:full_house, 25) if full_house?
    update_score(:four_of_a_kind, @roll_total) if four_of_a_kind?
    update_score(:three_of_a_kind, @roll_total) if three_of_a_kind?
    score_chance
    score_upper_section
    high_score
  end

  private

  def score_upper_section
    @tally.each { |num, count| update_score(NUM_TO_CATEGORY[num - 1], num * count) }
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

  def small_straight?
    STRAIGHTS[:small].include?(@unique_sorted)
  end

  def score_small_straight
    return unless @tally.size >= 4
    update_score(:small_straight, 30)
    high_score
  end

  def full_house?
    @sorted_tallies == [2, 3]
  end

  def four_of_a_kind?
    @max_tally >= 4
  end

  def three_of_a_kind?
    @max_tally >= 3
  end

  def score_chance
    update_score(:chance, @roll_total)
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
