require "minitest/autorun"
require_relative "yahtzee_scoring"
require 'logger'
require 'benchmark'

class TestYahtzeeScoring < Minitest::Test
  def setup
    @rolls = Array.new(100_000) { Array.new(5) { rand(1..6) } }
  end

  def test_best_score
    assert_equal({ category: :yahtzee, score: 50 }, YahtzeeScoring.best_score([6, 6, 6, 6, 6]))
    assert_equal({ category: :large_straight, score: 40 }, YahtzeeScoring.best_score([2, 3, 4, 5, 6]))
    assert_equal({ category: :three_of_a_kind, score: 21 }, YahtzeeScoring.best_score([6, 6, 6, 2, 1]))
    assert_equal({ category: :full_house, score: 25 }, YahtzeeScoring.best_score([3, 3, 3, 5, 5]))
    assert_equal({ category: :chance, score: 17 }, YahtzeeScoring.best_score([1, 2, 3, 5, 6]))
  end

  def test_benchmark
    execution_time = Benchmark.realtime do
      @rolls.each { |roll| YahtzeeScoring.best_score(roll) }
    end

    puts "\nExecution Time: #{execution_time.round(5)} seconds"

    assert_operator execution_time, :<, 0.7, "Performance regression detected!"
  end
end
