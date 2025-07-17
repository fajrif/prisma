class Admins::ArchiveTypesController < Admins::BaseController
	before_action :set_archive_type, except: [:index, :new, :create]

  def index
    criteria = ArchiveType.all
    @archive_types = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @archive_types }
      format.js
    end
  end

  def show
  end

  def new
    @archive_type = ArchiveType.new
  end

  def create
    @archive_type = ArchiveType.new(params_archive_type)
    if @archive_type.save
			redirect_to admins_archive_type_path(@archive_type.id), :notice => "Successfully created archive type."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @archive_type.update(params_archive_type)
			redirect_to admins_archive_type_path(@archive_type.id), :notice  => "Successfully updated archive type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @archive_type.destroy
    redirect_to admins_archive_types_url, :notice => "Successfully destroyed archive type."
  end

  private

  def params_archive_type
    params.require(:archive_type).permit(:name)
  end

	def set_archive_type
		@archive_type = ArchiveType.find(params[:id])
	end

end
