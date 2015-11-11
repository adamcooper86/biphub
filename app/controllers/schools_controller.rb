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
  end
  def edit
  end
  def update
  end
  def destroy
  end

  private

  def school_params
    params.require(:school).permit(:name, :address, :city, :state, :zip)
  end
end
