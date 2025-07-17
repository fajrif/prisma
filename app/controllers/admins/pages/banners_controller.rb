class Admins::Pages::BannersController < Admins::BaseController
	before_action :set_page

  def destroy
		@banner = @page.banners.find(params[:id])
		@banner.destroy
		flash[:notice] = "Banner deleted."

    respond_to do |format|
      format.js { render :action => :update }
    end
  end

	def sort
		params[:banner].each_with_index do |id, index|
			@page.banners.where(id: id).update_all(order_no: index + 1)
		end
		head :ok
	end

  private

	def set_page
		@page = Page.find(params[:page_id])
	end

end
