module FormOptionsHelper
  def speducator_options speducators
    speducators.map { |speducator|[speducator.first_name, speducator.id] }
  end

  def staff_options users
  	users.map { |user|[user.first_name, user.id]}
  end
end