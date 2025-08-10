class Admins::Services::BenefitsController < Admins::BaseController
	before_action :set_service

	def new
		@benefit = @service.benefits.build

    respond_to do |format|
      format.js { render :action => :form }
    end
	end

  def create
		@success = false
		@benefit = @service.benefits.build(params_benefit)
    if @benefit.save
      flash[:notice] = "Successfully add benefit"
			@success = true
			set_benefits
    end

    respond_to do |format|
      format.js { render :action => (@success == true ? :update : :form) }
    end
  end

	def edit
		@benefit = @service.benefits.find(params[:id])

    respond_to do |format|
      format.js { render :action => :form }
    end
	end

  def update
		@success = false
		@benefit = @service.benefits.find(params[:id])
    if @benefit.update(params_benefit)
      flash[:notice] = "Successfully update benefit"
			@success = true
    end

    respond_to do |format|
      format.js { render :action => (@success == true ? :update : :form) }
    end
  end

  def destroy
		@benefit = @service.benefits.find(params[:id])
		@benefit.destroy
		set_benefits
		flash[:notice] = "Benefit deleted."

    respond_to do |format|
      format.js { render :action => :update }
    end
  end

  private

  def params_benefit
    params.require(:benefit).permit(:service_id, :content)
  end

	def set_service
		@service = Service.find(params[:service_id])
	end

	def set_benefits
		@benefits = @service.benefits
	end

end
