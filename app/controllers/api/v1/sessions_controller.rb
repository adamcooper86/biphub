class Api::V1::SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      token = authenticity_token
      render :json => {token: token, id: @user.id }
    else
      render :json => {error: true}
    end
  end

  private
  def authenticity_token
    @user.create_authenticity_token
  end
end
