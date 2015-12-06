class Api::V1::ObservationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:authenticity_token]
      render json: []
    else
      render text: "Error: Authenticity token not provided", status: 403
    end
  end

end
