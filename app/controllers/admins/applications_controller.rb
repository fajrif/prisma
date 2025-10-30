class Admins::ApplicationsController < Admins::BaseController
	before_action :set_application, except: [:index]

  def index
		if params[:search].blank?
			criteria = Application.all
		else
			criteria = Application.where("name ILIKE ?", "%#{params[:search]}%")
		end

    @applications = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applications }
      format.js
    end
  end

  def show
  end

  def destroy
    @application.destroy
    redirect_to admins_applications_url, :notice => "Successfully destroyed application."
  end

  private

  def params_application
    params.require(:application).permit(:name, :email, :phone, :career_id, :file)
  end

  def set_application
		@application = Application.find(params[:id])
  end
end
