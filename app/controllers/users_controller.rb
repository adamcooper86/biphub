class UsersController < ApplicationController
  before_filter :authorize

  def show
    @user = User.find_by_id params[:id]
    @school = @user.school
    @coordinators = @school.coordinators
    @teachers = @school.teachers
    @speducators = @school.speducators
    @students = @school.students
    @observations = @user.observations.order('created_at DESC')
    @student = Student.find(params[:student_id]) if params[:student_id]
  end
end
