class Admins::BoostadServicesController < Admins::BaseController
	before_action :set_boostad_service, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = BoostadService.all
		else
			criteria = BoostadService.where("title ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end

    @boostad_services = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boostad_services }
      format.js
    end
  end

  def new
    @boostad_service = BoostadService.new
  end

  def create
    @boostad_service = BoostadService.new(params_boostad_service)
    if @boostad_service.save
			redirect_to admins_boostad_service_path(@boostad_service.id), :notice => "Successfully created boostad service."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @boostad_service.update(params_boostad_service)
			redirect_to admins_boostad_service_path(@boostad_service.id), :notice  => "Successfully updated boostad service."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @boostad_service.destroy
    redirect_to admins_boostad_services_url, :notice => "Successfully destroyed boostad service."
  end

  private

  def params_boostad_service
    params.require(:boostad_service).permit(:title, :description, :image)
  end

  def set_boostad_service
		@boostad_service = BoostadService.find(params[:id])
  end
end
