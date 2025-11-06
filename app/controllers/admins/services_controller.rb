class Admins::ServicesController < Admins::BaseController
	before_action :set_service, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Service.all
		else
			criteria = Service.where("name ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end

    @services = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @services }
      format.js
    end
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(params_service)
    if @service.save
			redirect_to admins_service_path(@service.id), :notice => "Successfully created service."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @service.update(params_service)
			redirect_to admins_service_path(@service.id), :notice  => "Successfully updated service."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @service.destroy
    redirect_to admins_services_url, :notice => "Successfully destroyed service."
  end

  private

  def params_service
    params.require(:service).permit(:image, :image_white, :image1, :name, :caption, :short_description, :description, :benefit_title, :benefit_description, :color, :banner_section_id)
  end

  def set_service
		@service = Service.find(params[:id])
  end
end
