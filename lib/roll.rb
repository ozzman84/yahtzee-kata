class Roll
  attr_reader :tally, :total

  def initialize(roll)
    @tally = roll.tally
    @total = roll.sum
  end

  def unique_sorted
    @unique_sorted ||= @tally.keys.sort
  end

  def sorted_tallies
    @sorted_tallies ||= @tally.values.sort
  end

  def max_tally
    @max_tally ||= sorted_tallies.last
  end
end