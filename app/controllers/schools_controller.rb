class SchoolsController < ApplicationController
  before_filter :authorize_admin

  def new
    @school = School.new
  end
  def create
    school = School.new(school_params)
    if school.save
      session[:school_id] = school.id
      redirect_to "/schools/#{ school.id }"
    else
      redirect_to '/schools/new'
    end
  end
  def show
    @school = School.find(params[:id])
    @coordinators = @school.coordinators
  end
  def edit
    @school = School.find(params[:id])
  end
  def update
    @school = School.find(params[:id])
    @school.update_attributes(school_params)
    redirect_to "/schools/#{ @school.id }"
  end
  def destroy
    @school = School.find(params[:id])
    @school.destroy
    redirect_to "/admins/#{current_user.id}"
  end

  private

  def school_params
    params.require(:school).permit(:name, :address, :city, :state, :zip)
  end
end
