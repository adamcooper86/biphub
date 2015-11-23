class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_by_email(params[:email])
    if @user
      if @user.authenticate(params[:password])
        token = authenticity_token
        render :json => {token: token, id: @user.id }
      else
        render :text => "User and Password Don't Match", :status => 403
      end
    else
      render :text => "User With That Email Not Found", :status => 403
    end
  end

  private
  def authenticity_token
    @user.create_authenticity_token
  end
end
