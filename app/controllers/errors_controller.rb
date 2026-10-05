class ErrorsController < ApplicationController
	layout "application"

  def show
    @status_code = (params[:code] || status_code_from_exception).to_i

    respond_to do |format|
      format.html { render :show, status: @status_code }
      format.json { render json: { error: Rack::Utils::HTTP_STATUS_CODES[@status_code] }, status: @status_code }
    end
  end

	private

	# Tanpa ini semua exception (termasuk halaman tidak ditemukan) dibalas 500,
	# sehingga crawler menganggap URL mati sebagai error server.
	def status_code_from_exception
		exception = request.env['action_dispatch.exception']
		return 500 if exception.blank?

		ActionDispatch::ExceptionWrapper.new(request.env, exception).status_code
	end

end
