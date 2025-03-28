require_relative 'roll'
require_relative 'of_a_kind'
require_relative 'straight'
require_relative 'full_house'

class YahtzeeScoring
  SCORING_RULES = [
    FullHouse,
    OfAKind,
    Straight
  ]

  def self.best_score(roll)
    roll_calc = Roll.new(roll)

    SCORING_RULES.each do |rule|
      if (result = rule.score(roll_calc))
        return result
      end
    end

    { category: :chance, score: roll_calc.total }
  end
end
