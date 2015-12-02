class TeachersController < ApplicationController
  def new
    @school = School.find_by_id params[:school_id]
    @user = Teacher.new
  end

  def create
    school = School.find_by_id params[:school_id]
    teacher = Teacher.new teacher_params
    if teacher.save
      school.teachers << teacher
      redirect_to school_teacher_path school, teacher
    else
      redirect_to new_school_teacher_path school
    end
  end

  def show
    @school = School.find_by_id params[:school_id]
    @user = Teacher.find_by_id params[:id]
  end

  def edit
    @school = School.find_by_id params[:school_id]
    @user = Teacher.find_by_id params[:id]
  end

  def update
    school = School.find(params[:school_id])
    teacher = Teacher.find_by_id params[:id]
    teacher.update_attributes(teacher_params)
    redirect_to school_teacher_path school, teacher
  end

  def destroy
    @school = School.find(params[:school_id])
    @teacher = Teacher.find_by_id params[:id]
    @teacher.destroy
    redirect_to "/users/#{current_user.id}"
  end

private
  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
