class AdminsController < ApplicationController
  before_filter :authorize_admin
  before_filter :authorize

  def show
    @schools = School.all
  end
end
