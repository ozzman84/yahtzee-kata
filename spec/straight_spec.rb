require './lib/straight'
require './lib/roll'

RSpec.describe Straight do
  describe "when evaluating a large straight" do
    it "returns 40 for [2, 3, 4, 5, 6]" do
      expect(Straight.score(Roll.new([2, 3, 4, 5, 6]))).to eq({ category: :large_straight, score: 40 })
    end

    it "returns 40 for [2, 3, 4, 5, 1]" do
      expect(Straight.score(Roll.new([1, 2, 3, 4, 5]))).to eq({ category: :large_straight, score: 40 })
    end
  end

  describe "when evaluating a small straight" do
    it "returns 30 for [2, 3, 4, 5, 5]" do
      expect(Straight.score(Roll.new([2, 3, 4, 5]))).to eq({ category: :small_straight, score: 30 })
    end

    it "returns 30 for [2, 4, 3, 2, 1]" do
      expect(Straight.score(Roll.new([1, 2, 3, 4]))).to eq({ category: :small_straight, score: 30 })
    end

    it "returns 30 for [6, 4, 3, 5, 6]" do
      expect(Straight.score(Roll.new([3, 4, 5, 6]))).to eq({ category: :small_straight, score: 30 })
    end
  end
end