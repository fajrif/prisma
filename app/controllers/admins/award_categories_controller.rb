class Admins::AwardCategoriesController < Admins::BaseController
	before_action :set_award_category, except: [:index, :new, :create]

  def index
    criteria = AwardCategory.all
    @award_categories = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @award_categories }
      format.js
    end
  end

  def show
  end

  def new
    @award_category = AwardCategory.new
  end

  def create
    @award_category = AwardCategory.new(params_award_category)
    if @award_category.save
			redirect_to admins_award_category_path(@award_category.id), :notice => "Successfully created award category."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @award_category.update(params_award_category)
			redirect_to admins_award_category_path(@award_category.id), :notice  => "Successfully updated award category."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @award_category.destroy
    redirect_to admins_award_categories_url, :notice => "Successfully destroyed award category."
  end

  private

  def params_award_category
    params.require(:award_category).permit(:image, :name, :description)
  end

	def set_award_category
		@award_category = AwardCategory.find(params[:id])
	end
end
