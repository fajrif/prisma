class Admins::Banners::LinkButtonsController < Admins::BaseController
	before_action :set_banner
	before_action :set_link_button, except: [:new, :create]

  def new
		@link_button = @banner.link_buttons.build

    respond_to do |format|
      format.js { render action: :form }
    end
  end

  def create
		@success = false
		@link_button = @banner.link_buttons.build(params_link_button)
    if @link_button.save
      flash[:notice] = "Successfully add link button"
			@success = true
    end

    respond_to do |format|
      format.js { render :action => (@success == true ? :update : :form) }
    end
  end

  def edit
    respond_to do |format|
      format.js { render action: :form }
    end
  end

  def update
		@success = false
    if @link_button.update(params_link_button)
      flash[:notice] = "Successfully update link button"
			@success = true
    end

    respond_to do |format|
      format.js { render :action => (@success == true ? :update : :form) }
    end
  end

  def destroy
    @link_button.destroy

		flash[:notice] = "Link button deleted"
		@success = true

    respond_to do |format|
      format.js { render action: :update }
    end
  end

  private

  def params_link_button
    params.require(:link_button).permit(:route_category, :link_text, :link_url, :anchor, :open_new_tab, :objectable_type, :objectable_id)
  end

  def set_banner
		@banner = Banner.find(params[:banner_id])
  end

  def set_link_button
		@link_button = @banner.link_buttons.find(params[:id])
		set_objectables
  end

	def set_objectables
		@objectables = []
		if @link_button.is_object_route?
			@objectables = @link_button.objectable.class.all
		end
	end
end
