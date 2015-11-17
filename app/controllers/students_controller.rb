class StudentsController < ApplicationController
    def new
      @school = School.find_by_id params[:school_id]
      @student = Student.new
    end

    def create
      school = School.find_by_id params[:school_id]
      student = Student.new student_params
      if student.save
        school.students << student
        redirect_to school_student_path school, student
      else
        redirect_to new_school_student_path school
      end
    end

    def show
      @school = School.find_by_id params[:school_id]
      @student = Student.find_by_id params[:id]
      @speducator = @student.speducator
      @staff_members = @student.staff_members
    end

    def edit
      @school = School.find_by_id params[:school_id]
      @speducators = @school.speducators
      @student = Student.find_by_id params[:id]
    end

    def update
      @school = School.find(params[:school_id])
      @student = Student.find_by_id params[:id]
      @student.update_attributes(student_params)
      redirect_to "/users/#{current_user.id}"
    end

    def destroy
      @school = School.find(params[:school_id])
      @student = Student.find_by_id params[:id]
      @student.destroy
      redirect_to "/users/#{current_user.id}"
    end

    def team
      @school = School.find_by_id params[:school_id]
      @staff = @school.users
      @student = Student.find_by_id params[:id]
      @speducator = @student.speducator
      @staff_members = @student.staff_members
    end

  private
    def student_params
      params.require(:student).permit(:first_name, :last_name, :speducator_id)
    end
end
