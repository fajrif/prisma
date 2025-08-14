class Admins::PortfoliosController < Admins::BaseController
	before_action :set_portfolio, except: [:index, :new, :create]

  def index
		if params[:search].blank?
      criteria = Portfolio.all
		else
			criteria = Portfolio.where("name ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end
    @portfolios = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @portfolios }
      format.js
    end
  end

  def show
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(params_portfolio)
    if @portfolio.save
      redirect_to admins_portfolio_path(@portfolio.id), :notice => "Successfully created portfolio."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @portfolio.update(params_portfolio)
      redirect_to admins_portfolio_path(@portfolio.id), :notice  => "Successfully updated portfolio."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @portfolio.destroy
    redirect_to admins_portfolios_url, :notice => "Successfully destroyed portfolio."
  end

  private

  def params_portfolio
    params.require(:portfolio).permit(:video_url, :service_id, :industry_id, :name, :logo, :image, :image1, :image2, :banner, :caption, :short_description, :description, :about_campaign, :area_coverage, :media_used, :collaborators, :creative_highlights)
  end

  def set_portfolio
		@portfolio = Portfolio.find(params[:id])
  end
end
