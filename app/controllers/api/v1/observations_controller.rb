class Api::V1::ObservationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: []
  end

end
