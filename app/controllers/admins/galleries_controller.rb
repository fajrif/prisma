class Admins::GalleriesController < Admins::BaseController
	before_action :set_gallery, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Gallery.all
		else
			criteria = Gallery.where("title ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end
    @galleries = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galleries }
      format.js
    end
  end

  def show
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(params_gallery)
    if @gallery.save
      redirect_to admins_gallery_path(@gallery), :notice => "Successfully created gallery."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @gallery.update(params_gallery)
      redirect_to admins_gallery_path(@gallery), :notice  => "Successfully updated gallery."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gallery.destroy
    redirect_to admins_galleries_url, :notice => "Successfully destroyed gallery."
  end

  private

  def params_gallery
    params.require(:gallery).permit(:image, :title, :caption, :video_url)
  end

  def set_gallery
		@gallery = Gallery.find(params[:id])
  end

end
