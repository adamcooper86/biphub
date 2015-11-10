class AdminsController < ApplicationController
  before_filter :authorize_admin

  def show
  end
end
