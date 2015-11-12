class AdminsController < ApplicationController
  before_filter :authorize_admin

  def show
    @schools = School.all
  end
end
