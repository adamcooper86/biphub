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
      @user = User
      @school = School.find_by_id params[:school_id]
      @student = Student.find_by_id params[:id]
      @speducator = @student.speducator
      @cards = @student.cards
    end

    def edit
      @school = School.find_by_id params[:school_id]
      @speducators = @school.speducators
      @student = Student.find_by_id params[:id]
      @cards = @student.cards
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

  private
    def student_params
      params.require(:student).permit(:first_name, :last_name, :speducator_id)
    end
end
