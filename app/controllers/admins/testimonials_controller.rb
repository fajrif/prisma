class Admins::TestimonialsController < Admins::BaseController
	before_action :set_testimonial, except: [:index, :new, :create]

  def index
    criteria = Testimonial.where("company_name ILIKE ?", "%#{params[:search]}%")
    @testimonials = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @testimonials }
      format.js
    end
  end

  def show
  end

  def new
    @testimonial = Testimonial.new
  end

  def create
    @testimonial = Testimonial.new(params_testimonial)
    if @testimonial.save
      redirect_to admins_testimonial_path(@testimonial), :notice => "Successfully created testimonial."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @testimonial.update(params_testimonial)
      redirect_to admins_testimonial_path(@testimonial), :notice  => "Successfully updated testimonial."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @testimonial.destroy
    redirect_to admins_testimonials_url, :notice => "Successfully destroyed testimonial."
  end

  private

  def params_testimonial
    params.require(:testimonial).permit(:name, :title, :company_name, :message, :image)
  end

	def set_testimonial
		@testimonial = Testimonial.find(params[:id])
	end

end
