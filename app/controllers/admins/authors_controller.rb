class Admins::AuthorsController < Admins::BaseController
	before_action :set_author, except: [:index, :new, :create]

  def index
    criteria = Author.where("name ILIKE ?", "%#{params[:search]}%")
    @authors = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @authors }
      format.js
    end
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(params_author)
    if @author.save
			redirect_to admins_author_path(@author.id), :notice => "Successfully created author."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @author.update(params_author)
			redirect_to admins_author_path(@author.id), :notice  => "Successfully updated author."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @author.destroy
    redirect_to admins_authors_url, :notice => "Successfully destroyed author."
  end

  private

  def params_author
    params.require(:author).permit(:name, :title, :company_name, :email, :phone)
  end

  def set_author
		@author = Author.find(params[:id])
  end
end
