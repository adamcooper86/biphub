class Api::V1::ObservationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:authenticity_token] && params[:user_id]
      @user = authenticated_user params[:user_id], params[:authenticity_token]
      if @user
        @observations = @user.observations
        @observations = Observation.unanswered_observation_collection @observations
        render :json => @observations
      else
        render text: "Error: Could not authenticate user", status: 403
      end
    elsif params[:user_id]
      render text: "Error: Authenticity token not provided", status: 403
    else
      render text: "Error: User_id not provided", status: 403
    end
  end

  private
  def authenticated_user user_id, authenticity_token
    user = User.find(user_id)
    user if user.authenticity_token == authenticity_token
  end
end
