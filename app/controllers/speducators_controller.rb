class SpeducatorsController < ApplicationController
  before_filter{ |controller| controller.authorize_coordinator params[:school_id] }

  def new
    @school = School.find_by_id params[:school_id]
    @user = Speducator.new
  end

  def create
    school = School.find_by_id params[:school_id]
    speducator = Speducator.new speducator_params
    school.speducators << speducator if school
    if speducator.save
      redirect_to school_speducator_path school, speducator
    else
      redirect_to "/schools/#{params[:school_id]}/speducators/new"
    end
  end

  def show
    @school = School.find_by_id params[:school_id]
    @user = Speducator.find_by_id params[:id]
  end

  def edit
    @school = School.find_by_id params[:school_id]
    @user = Speducator.find_by_id params[:id]
  end

  def update
    school = School.find(params[:school_id])
    speducator = Speducator.find_by_id params[:id]
    if speducator.update_attributes(speducator_params)
      redirect_to school_speducator_path school, speducator
    else
      redirect_to edit_school_speducator_path school, speducator
    end
  end

  def destroy
    @school = School.find(params[:school_id])
    @speducator = Speducator.find_by_id params[:id]
    @speducator.destroy
    redirect_to "/users/#{current_user.id}"
  end

private
  def speducator_params
    params.require(:speducator).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
