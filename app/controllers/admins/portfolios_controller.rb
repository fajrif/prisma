class Admins::PortfoliosController < Admins::BaseController
	before_action :set_portfolio, except: [:index, :new, :create]

  def index
    criteria = Portfolio.all
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
      redirect_to admins_portfolio_path(@portfolio), :notice => "Successfully created portfolio."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @portfolio.update(params_portfolio)
      redirect_to admins_portfolio_path(@portfolio), :notice  => "Successfully updated portfolio."
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
    params.require(:portfolio).permit(:name, :company_name, :description, :image, :page_id)
  end

  def set_portfolio
		@portfolio = Portfolio.find(params[:id])
  end
end
