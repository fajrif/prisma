class Admins::CareersController < Admins::BaseController
	before_action :set_career, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Career.all
		else
			criteria = Career.where("title ILIKE ?", "%#{params[:search]}%")
		end

    @careers = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @careers }
      format.js
    end
  end

  def new
    @career = Career.new
  end

  def create
    @career = Career.new(params_career)
    if @career.save
			redirect_to admins_career_path(@career.id), :notice => "Successfully created career."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @career.update(params_career)
			redirect_to admins_career_path(@career.id), :notice  => "Successfully updated career."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @career.destroy
    redirect_to admins_careers_url, :notice => "Successfully destroyed career."
  end

	def delete_attachment
		if @asset = ActiveStorage::Attachment.find(params[:asset_id])
			flash[:notice] = "Successfully delete attachment."
			@career.file.purge
		end
		redirect_to admins_career_path(@career.id)
	end

  private

  def params_career
    params.require(:career).permit(:title, :short_description, :content, :published_date, :status, :location, :file, :company_name)
  end

  def set_career
		@career = Career.find(params[:id])
  end
end
