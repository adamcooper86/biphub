class ReportsController < ApplicationController
  def index
    @user = current_user
    @students = @user.case_students
  end
end
