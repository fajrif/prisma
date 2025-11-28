class Admins::PixServicesController < Admins::BaseController
	before_action :set_pix_service, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = PixService.all
		else
			criteria = PixService.where("title ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end

    @pix_services = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pix_services }
      format.js
    end
  end

  def new
    @pix_service = PixService.new
  end

  def create
    @pix_service = PixService.new(params_pix_service)
    if @pix_service.save
			redirect_to admins_pix_service_path(@pix_service.id), :notice => "Successfully created pix service."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pix_service.update(params_pix_service)
			redirect_to admins_pix_service_path(@pix_service.id), :notice  => "Successfully updated pix service."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @pix_service.destroy
    redirect_to admins_pix_services_url, :notice => "Successfully destroyed pix service."
  end

  private

  def params_pix_service
    params.require(:pix_service).permit(:title, :description)
  end

  def set_pix_service
		@pix_service = PixService.find(params[:id])
  end
end
