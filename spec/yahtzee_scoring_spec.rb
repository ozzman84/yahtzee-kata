require "./lib/yahtzee_scoring"
require "benchmark"

RSpec.describe YahtzeeScoring do
  before(:each) do
    @rolls = Array.new(100_000) { Array.new(5) { rand(1..6) } }
  end

  describe ".best_score" do
    context "when evaluating Yahtzee" do
      it "returns 50 for a yahtzee of 6s" do
        expect(YahtzeeScoring.best_score([6, 6, 6, 6, 6])).to eq({ category: :yahtzee, score: 50 })
      end

      it "returns 50 for a yahtzee of 1s" do
        expect(YahtzeeScoring.best_score([1, 1, 1, 1, 1])).to eq({ category: :yahtzee, score: 50 })
      end
    end

    context "when evaluating four of a kind" do
      it "returns the correct score for [2, 2, 2, 2, 1]" do
        expect(YahtzeeScoring.best_score([2, 2, 2, 2, 1])).to eq({ category: :four_of_a_kind, score: 9 })
      end
    end

    context "when evaluating three of a kind" do
      it "returns the correct score for [6, 6, 6, 2, 1]" do
        expect(YahtzeeScoring.best_score([6, 6, 6, 2, 1])).to eq({ category: :three_of_a_kind, score: 21 })
      end

      it "returns the correct score for [4, 4, 4, 2, 1]" do
        expect(YahtzeeScoring.best_score([4, 4, 4, 2, 1])).to eq({ category: :three_of_a_kind, score: 15 })
      end
    end

    context "when evaluating chance" do
      it "returns 17 for [1, 2, 3, 5, 6]" do
        expect(YahtzeeScoring.best_score([1, 2, 3, 5, 6])).to eq({ category: :chance, score: 17 })
      end
    end

    context "performance" do
      it "executes within the performance threshold" do
        execution_time = Benchmark.realtime do
          @rolls.each { |roll| YahtzeeScoring.best_score(roll) }
        end

        puts "\nExecution Time: #{execution_time.round(5)} seconds"
        expect(execution_time).to be < 0.7
      end
    end
  end
end