class Admins::PagesController < Admins::BaseController
	before_action :set_page, except: [:index, :new, :create]

  def index
		criteria = Page.where("title ILIKE ?", "%#{params[:search]}%")
    @pages = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
      format.js
    end
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params_page)
    if @page.save
			redirect_to admins_page_path(@page.id), :notice => "Successfully created page."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @page.update(params_page)
			redirect_to admins_page_path(@page.id), :notice  => "Successfully updated page."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to admins_pages_url, :notice => "Successfully destroyed page."
  end

  private

  def params_page
    params.require(:page).permit(:title, :content, :banner_section_id, :meta_title, :meta_description, :published_date, :status)
  end

  def set_page
		@page = Page.find(params[:id])
  end
end
