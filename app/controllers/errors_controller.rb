class ErrorsController < ApplicationController
	layout "application"

  def show
    @exception = request.env["action_dispatch.exception"]
    @status_code = @exception.try(:status_code) ||
                   ActionDispatch::ExceptionWrapper.new(
                    request.env, @exception
                  ).status_code

    render :show, status: @status_code
  end

  private

	def view_for_code(code)
		supported_error_codes.fetch(code, "404")
	end

	def supported_error_codes
		{
			422 => "422",
			403 => "403",
			404 => "404",
			500 => "500"
		}
	end
end
