class Admins::ProductCategoriesController < Admins::BaseController
	before_action :set_product_category, except: [:index, :new, :create]

  def index
    criteria = ProductCategory.all
    @product_categories = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_categories }
      format.js
    end
  end

  def show
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(params_product_category)
    if @product_category.save
			redirect_to admins_product_category_path(@product_category.id), :notice => "Successfully created product category."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @product_category.update(params_product_category)
			redirect_to admins_product_category_path(@product_category.id), :notice  => "Successfully updated product category."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product_category.destroy
    redirect_to admins_product_categories_url, :notice => "Successfully destroyed product category."
  end

  private

  def params_product_category
    params.require(:product_category).permit(:name)
  end

	def set_product_category
		@product_category = ProductCategory.find(params[:id])
	end
end
