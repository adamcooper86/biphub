class Goal < ActiveRecord::Base
  belongs_to :bip
  has_many :records

  validates :bip, :text, :prompt, :meme, presence: true

  def avg_growth
    results = self.records.map{ |record| record.result }.compact
    if results.length > 1
      scores = results.map{|result| performance_score_for result }
      growth = []
      for i in 0...scores.length - 1
        growth[i] = scores[i+1] - scores[i]
      end
      average_result = growth.inject(0.0) { |sum, el| sum + el } / growth.size
    elsif results.length > 0
      0.0
    else
      raise RuntimeError, "There were no answered records"
    end
    rescue
    nil
  end

  def avg_performance
    results = self.records.map{ |record| record.result }.compact
    if results.length > 0
      average_result = results.inject(0.0) { |sum, el| sum + el } / results.size
    else
      raise RuntimeError, "There were no answered records"
    end

    performance_score_for average_result

    rescue
    nil
  end

private
  def performance_score_for result
    if self.meme == "Qualitative"
      coefficient = result.to_f / 5
      coefficient * 100
    elsif self.meme == "Percentage"
      result.to_f
    elsif self.meme == "Boolean"
      result.to_f * 100
    elsif self.meme == "Incidence"
      target = self.target || 0
      if result <= target
        100.0
      else
        adjusted_result = result - target
        if target > 0
          triple = 3 * target
        else
          triple = 3
        end
        coefficient = adjusted_result.to_f / triple
        coefficient = 1 - coefficient
        coefficient = 0 unless coefficient > 0
        coefficient * 100
      end
    elsif self.meme == "Time"
      target = self.target || 5
      if result >= target
        100.0
      elsif result <= 0
        0.0
      else
        coefficient = result.to_f / target
        coefficient * 100
      end
    end
  end
end
