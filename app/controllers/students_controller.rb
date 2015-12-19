class StudentsController < ApplicationController
  before_filter(except: :show){ |controller| controller.authorize_coordinator params[:school_id] }

  def new
    @school = School.find_by_id params[:school_id]
    @student = Student.new
  end

  def create
    school = School.find_by_id params[:school_id]
    student = Student.new student_params
    school.students << student if school
    if student.save
      redirect_to school_student_path school, student
    else
      redirect_to "/schools/#{params[:school_id]}/students/new"
    end
  end

  def show
    @user = User
    @school = School.find_by_id params[:school_id]
    @student = Student.find_by_id params[:id]
    @speducator = @student.speducator
    @staff_members = @student.staff_members
    @cards = @student.cards
    @bips = @student.bips
  end

  def edit
    @school = School.find_by_id params[:school_id]
    @speducators = @school.speducators
    @student = Student.find_by_id params[:id]
    @cards = @student.cards
  end

  def update
    school = School.find(params[:school_id])
    student = Student.find_by_id params[:id]
    if student.update_attributes(student_params)
      redirect_to school_student_path school, student
    else
      redirect_to edit_school_student_path school, student
    end
  end

  def destroy
    @school = School.find(params[:school_id])
    @student = Student.find_by_id params[:id]
    @student.destroy
    redirect_to "/users/#{current_user.id}"
  end

private
  def student_params
    params.require(:student).permit(:first_name, :last_name, :speducator_id, :school_id)
  end
end
