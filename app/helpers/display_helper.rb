module DisplayHelper
  def even_or_odd count
    count.even? ? "even" : "odd"
  end
end