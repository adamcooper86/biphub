class ReportsController < ApplicationController


  def index
    @user = current_user
    if @user.is_a? Admin
      @schools = School.all
      if params[:school_id]
        @school = School.find(params[:school_id])
      end
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
