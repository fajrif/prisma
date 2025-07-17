class Admins::ArchivesController < Admins::BaseController
	before_action :set_archive, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Archive.all
		else
			criteria = Archive.where("title ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end

		unless params[:archive_type_id].blank?
			criteria = criteria.where("archive_type_id = ?", "#{params[:archive_type_id]}")
		end
    @archives = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @archives }
      format.js
    end
  end

  def show
  end

  def new
    @archive = Archive.new
  end

  def create
    @archive = Archive.new(params_archive)
    if @archive.save
      redirect_to admins_archive_path(@archive), :notice => "Successfully created archive."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @archive.update(params_archive)
      redirect_to admins_archive_path(@archive), :notice  => "Successfully updated archive."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @archive.destroy
    redirect_to admins_archives_url, :notice => "Successfully destroyed archive."
  end

  private

  def params_archive
		params.require(:archive).permit(:file, :title, :short_description, :published_date, :status, :archive_type_id, :category_name, :private, :read_only)
  end

	def set_archive
		@archive = Archive.find(params[:id])
	end

end
