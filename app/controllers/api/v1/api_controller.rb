class ApiController < ActionController::API
private
  def authenticated_user user_id, authenticity_token
    user = User.find(user_id)
    user if user.authenticity_token == authenticity_token
  end
end