class Goal < ActiveRecord::Base
  belongs_to :bip
  has_many :records

  validates :bip, :text, :prompt, :meme, presence: true

  def avg_performance
    results = self.records.map{ |record| record.result }
    average_result = results.inject(0.0) { |sum, el| sum + el } / results.size
    if self.meme == "Qualitative"
      (average_result / 5) *100
    elsif self.meme == "Percentage"
      average_result
    end
  end
end
