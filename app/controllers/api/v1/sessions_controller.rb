class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      render :json => {token: authenticity_token, id: user.id }
    else
      render :json => {error: true}
    end
  end

  private
  def authenticity_token
    1
  end
end
