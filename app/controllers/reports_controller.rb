class ReportsController < ApplicationController
  def index
    @user = current_user
    @students = @user.case_students

#check to see that the student id passed in params matches any student id in the teachers caseload
    if params[:student_id]
      @student = Student.find(params[:student_id])
      @student = nil unless @students.include?(@student)
    end
  end
end
