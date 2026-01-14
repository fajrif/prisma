class Admins::ProductsController < Admins::BaseController
	before_action :set_product, except: [:index, :new, :create]

  def index
		if params[:search].blank?
      criteria = Product.all
		else
			criteria = Product.where("name ILIKE ?", "%#{params[:search]}%")
		end
    @products = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
      format.js
    end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params_product)
    if @product.save
      redirect_to admins_product_path(@product.id), :notice => "Successfully created product."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @product.update(params_product)
      redirect_to admins_product_path(@product.id), :notice  => "Successfully updated product."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to admins_products_url, :notice => "Successfully destroyed product."
  end

  private

  def params_product
    params.require(:product).permit(:name, :description, :product_category_id, :location_id, :specification, :est_impression, :longitude, :latitude, :address, :interest, :video_url, :image, :image1, :image2, :banner, :billboard_type)
  end

  def set_product
		@product = Product.find(params[:id])
  end
end
