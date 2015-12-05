class ObservationsController < ApplicationController
  def show
    @observation = Observation.find params[:id]
  end
  def edit
    @observation = Observation.find params[:id]
    @school = @observation.user.school
    @staff = @school.users
  end
  def update
    @observation = Observation.find params[:id]
    @observation.update_attributes(observation_params)
    redirect_to observation_path @observation
  end

  private
  def observation_params
    params.require(:observation).permit(:student_id, :user_id, :start, :finish)
  end
end
