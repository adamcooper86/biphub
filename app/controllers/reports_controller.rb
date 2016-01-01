class ReportsController < ApplicationController

  def index
    @user = current_user
    if @user.is_a? Admin
      @schools = School.all
      if params[:school_id]
        @school = School.find(params[:school_id])
      end

      @grade = params[:grade_lvl]
      @grade = nil if @grade == ""

      @gender = params[:gender]
      @gender = nil if @gender == ""

      @race = params[:race]
      @race = nil if @race == ""

      @speducator_id = params[:speducator_id]
      @speducator_id = nil if @speducator_id == ""

      @filter = { grade: @grade, gender: @gender, race: @race, speducator_id: @speducator_id }
      render "admin_index"
    elsif @user
      @students = @user.case_students
      if params[:student_id]
        @student = Student.find(params[:student_id])
        @student = nil unless @students.include?(@student)
      end
    else
      redirect_to login_path
    end
  end
end
