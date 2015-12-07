require_relative 'api_controller'

class Api::V1::ObservationsController < ApiController

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
end
