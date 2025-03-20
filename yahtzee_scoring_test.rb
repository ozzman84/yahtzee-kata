require "minitest/autorun"
require_relative "yahtzee_scoring"
require 'logger'
require 'benchmark'

class TestYahtzeeScoring < Minitest::Test
  def setup
    @rolls = Array.new(100_000) { Array.new(5) { rand(1..6) } }
  end

  #Best Score
  #Yahtzee
  def test_best_score_yahtzee
    assert_equal({ category: :yahtzee, score: 50 }, YahtzeeScoring.best_score([6, 6, 6, 6, 6]))
  end

  def test_best_score_yahtzee_low
    assert_equal({ category: :yahtzee, score: 50 }, YahtzeeScoring.best_score([1, 1, 1, 1, 1]))
  end

  #Large Straight
  def test_best_score_large_straight1
    assert_equal({ category: :large_straight, score: 40 }, YahtzeeScoring.best_score([2, 3, 4, 5, 6]))
  end

  def test_best_score_large_straight2
    assert_equal({ category: :large_straight, score: 40 }, YahtzeeScoring.best_score([2, 3, 4, 5, 1]))
  end

  #Small Straight
  def test_best_score_small_straight1
    assert_equal({ category: :small_straight, score: 30 }, YahtzeeScoring.best_score([2, 3, 4, 5, 5]))
  end

  def test_best_score_small_straight2
    assert_equal({ category: :small_straight, score: 30 }, YahtzeeScoring.best_score([2, 4, 3, 2, 1]))
  end

  def test_best_score_small_straight3
    assert_equal({ category: :small_straight, score: 30 }, YahtzeeScoring.best_score([6, 4, 3, 5, 6]))
  end
  
  #Four of a Kind
  def test_best_score_three_of_a_kind
    assert_equal({ category: :four_of_a_kind, score: 21 }, YahtzeeScoring.best_score([2, 2, 2, 2, 1]))
  end

  #Three of a Kind
  def test_best_score_three_of_a_kind
    assert_equal({ category: :three_of_a_kind, score: 21 }, YahtzeeScoring.best_score([6, 6, 6, 2, 1]))
  end

  def test_best_score_three_of_a_kind
    assert_equal({ category: :three_of_a_kind, score: 15 }, YahtzeeScoring.best_score([4, 4, 4, 2, 1]))
  end
  
  #Full House
  def test_best_score_full_house
    assert_equal({ category: :full_house, score: 25 }, YahtzeeScoring.best_score([3, 3, 3, 5, 5]))
  end

  #Chance
  def test_best_score_chance
    assert_equal({ category: :chance, score: 17 }, YahtzeeScoring.best_score([1, 2, 3, 5, 6]))
  end

  #Edgecases
  #Could be three of a kind, chance, or full house
  def test_three_of_a_kind_vs_three_of_a_kind
    assert_equal({ category: :three_of_a_kind, score: 28 }, YahtzeeScoring.best_score([5, 5, 6, 6, 6]))
  end

  def test_benchmark
    execution_time = Benchmark.realtime do
      @rolls.each { |roll| YahtzeeScoring.best_score(roll) }
    end

    puts "\nExecution Time: #{execution_time.round(5)} seconds"

    assert_operator execution_time, :<, 0.7, "Performance regression detected!"
  end
end
