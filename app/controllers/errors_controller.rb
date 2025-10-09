class ErrorsController < ApplicationController
	layout "application"

  def show
    @status_code = params[:code] || 500
    respond_to do |format|
      format.html { render :show, status: @status_code }
      format.json { render json: { error: Rack::Utils::HTTP_STATUS_CODES[@status_code.to_i] }, status: @status_code }
    end
  end

end
