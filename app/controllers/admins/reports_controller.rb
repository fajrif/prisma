class Admins::ReportsController < Admins::BaseController
	before_action :set_report, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Report.all
		else
			criteria = Report.where("title ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end

		unless params[:report_type_id].blank?
			criteria = criteria.where("report_type_id = ?", "#{params[:report_type_id]}")
		end
    @reports = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
      format.js
    end
  end

  def show
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params_report)
    if @report.save
      redirect_to admins_report_path(@report), :notice => "Successfully created report."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @report.update(params_report)
      redirect_to admins_report_path(@report), :notice  => "Successfully updated report."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report.destroy
    redirect_to admins_reports_url, :notice => "Successfully destroyed report."
  end

  private

  def params_report
		params.require(:report).permit(:file, :title, :short_description, :published_date, :status, :report_type_id, :private, :read_only, :author_id)
  end

  def set_report
		@report = Report.find(params[:id])
  end
end
