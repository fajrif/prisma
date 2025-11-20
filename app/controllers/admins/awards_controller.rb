class Admins::AwardsController < Admins::BaseController
	before_action :set_award, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Award.all
		else
			criteria = Award.where("name ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end
    @awards = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @awards }
      format.js
    end
  end

  def show
  end

  def new
    @award = Award.new
  end

  def create
    @award = Award.new(params_award)
    if @award.save
      redirect_to admins_award_path(@award), :notice => "Successfully created award."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @award.update(params_award)
      redirect_to admins_award_path(@award), :notice  => "Successfully updated award."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @award.destroy
    redirect_to admins_awards_url, :notice => "Successfully destroyed award."
  end

  private

  def params_award
    params.require(:award).permit(:image, :name, :description, :award_category_id)
  end

	def set_award
		@award = Award.find(params[:id])
	end

end
