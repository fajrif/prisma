class Admins::ReportTypesController < Admins::BaseController
	before_action :set_report_type, except: [:index, :new, :create]

  def index
    criteria = ReportType.all
    @report_types = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @report_types }
      format.js
    end
  end

  def show
  end

  def new
    @report_type = ReportType.new
  end

  def create
    @report_type = ReportType.new(params_report_type)
    if @report_type.save
			redirect_to admins_report_type_path(@report_type.id), :notice => "Successfully created report type."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @report_type.update(params_report_type)
			redirect_to admins_report_type_path(@report_type.id), :notice  => "Successfully updated report type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report_type.destroy
    redirect_to admins_report_types_url, :notice => "Successfully destroyed report type."
  end

  private

  def params_report_type
    params.require(:report_type).permit(:name)
  end

	def set_report_type
		@report_type = ReportType.find(params[:id])
	end
end
