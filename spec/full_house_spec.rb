require './lib/full_house'

RSpec.describe FullHouse do
  describe "Full house" do
    it "returns 25 for [3, 3, 3, 5, 5]" do
      expect(YahtzeeScoring.best_score([3, 3, 3, 5, 5])).to eq({ category: :full_house, score: 25 })
    end
  end

  describe "with edge cases" do
    it "returns three of a kind score 28 for [5, 5, 6, 6, 6]" do
      expect(YahtzeeScoring.best_score([5, 5, 6, 6, 6])).to eq({ category: :three_of_a_kind, score: 28 })
    end
  end
end