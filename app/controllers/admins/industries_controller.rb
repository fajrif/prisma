class Admins::IndustriesController < Admins::BaseController
	before_action :set_industry, except: [:index, :new, :create]

  def index
    criteria = Industry.all
    @industries = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @industries }
      format.js
    end
  end

  def show
  end

  def new
    @industry = Industry.new
  end

  def create
    @industry = Industry.new(params_industry)
    if @industry.save
			redirect_to admins_industry_path(@industry.id), :notice => "Successfully created industry."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @industry.update(params_industry)
			redirect_to admins_industry_path(@industry.id), :notice  => "Successfully updated industry."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @industry.destroy
    redirect_to admins_industries_url, :notice => "Successfully destroyed industry."
  end

  private

  def params_industry
    params.require(:industry).permit(:image, :name, :caption, :description, :banner_section_id, :meta_title, :meta_description)
  end

	def set_industry
		@industry = Industry.find(params[:id])
	end
end
