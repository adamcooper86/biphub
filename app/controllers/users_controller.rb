class UsersController < ApplicationController
  before_filter :authorize

  def show
    @user = User.find_by_id params[:id]
    @school = @user.school
    @coordinators = @school.coordinators
    @teachers = @school.teachers
    @speducators = @school.speducators
    @students = @school.students
    @observations = @user.observations
  end
end
