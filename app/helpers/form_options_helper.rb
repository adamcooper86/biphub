module FormOptionsHelper
  def speducator_options speducators
    speducators.map { |speducator|[speducator.first_name, speducator.id] }
  end
end