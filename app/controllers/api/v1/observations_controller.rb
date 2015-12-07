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

  def update
    if params[:authenticity_token] && params[:user_id]
      @user = authenticated_user params[:user_id], params[:authenticity_token]
      if @user
        @observation = Observation.find params[:id]
        if @observation.update_attributes(observation_params)
          render :json =>  { observation: @observation, records: @observation.records }
        else
          render text: "Error: Could not update the observation", status: 403
        end
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
  def observation_params
    params.require(:observation).permit(:student_id, :user_id, :start, :finish, {records_attributes: [:id, :result]})
  end
end
