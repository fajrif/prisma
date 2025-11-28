class Admins::LocationsController < Admins::BaseController
	before_action :set_location, except: [:index, :new, :create]

  def index
    criteria = Location.all
    @locations = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
      format.js
    end
  end

  def show
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params_location)
    if @location.save
      redirect_to admins_location_path(@location.id), :notice => "Successfully created location."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @location.update(params_location)
      redirect_to admins_location_path(@location.id), :notice  => "Successfully updated location."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @location.destroy
    redirect_to admins_locations_url, :notice => "Successfully destroyed location."
  end

  private

  def params_location
    params.require(:location).permit(:name, :description, :image, :banner_section_id)
  end

  def set_location
		@location = Location.find(params[:id])
  end
end
