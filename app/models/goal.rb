class Goal < ActiveRecord::Base
  belongs_to :bip
  has_many :records

  validates :bip, :text, :prompt, :meme, presence: true

  def avg_performance
    results = self.records.map{ |record| record.result }.compact
    if results.length > 0
      average_result = results.inject(0.0) { |sum, el| sum + el } / results.size
    else
      raise RuntimeError, "There were no answered records"
    end
    if self.meme == "Qualitative"
      (average_result / 5) *100
    elsif self.meme == "Percentage"
      average_result
    elsif self.meme == "Boolean"
      average_result * 100
    elsif self.meme == "Incidence"
      target = self.target || 0
      if average_result <= target
        100.0
      else
        adjusted_result = average_result - target
        if target > 0
          triple = 3 * target
        else
          triple = 3
        end
        coefficient = adjusted_result / triple
        coefficient = 1 - coefficient
        coefficient = 0 unless coefficient > 0
        coefficient * 100
      end
    elsif self.meme == "Time"
      target = self.target || 5
      if average_result >= target
        100.0
      elsif average_result <= 0
        0.0
      else
        coefficient = average_result / target
        coefficient * 100
      end
    end
    rescue
    nil
  end
end
