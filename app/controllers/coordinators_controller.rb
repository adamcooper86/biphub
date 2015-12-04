class CoordinatorsController < ApplicationController
  before_filter :authorize_admin

  def new
    @school = School.find_by_id params[:school_id]
    @coordinator = Coordinator.new
  end

  def create
    school = School.find_by_id params[:school_id]
    coordinator = Coordinator.new coordinator_params
    school.coordinators << coordinator
    if coordinator.save
      redirect_to school_coordinator_path school, coordinator
    else
      redirect_to new_school_coordinator_path school
    end
  end

  def show
    @school = School.find_by_id params[:school_id]
    @coordinator = Coordinator.find_by_id params[:id]
  end

  def edit
    @school = School.find_by_id params[:school_id]
    @coordinator = Coordinator.find_by_id params[:id]
  end

  def update
    @school = School.find(params[:school_id])
    @coordinator = Coordinator.find_by_id params[:id]
    @coordinator.update_attributes(coordinator_params)
    redirect_to school_path @school
  end

  def destroy
    @school = School.find(params[:school_id])
    @coordinator = Coordinator.find_by_id params[:id]
    @coordinator.destroy
    redirect_to school_path @school
  end

private
  def coordinator_params
    params.require(:coordinator).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
