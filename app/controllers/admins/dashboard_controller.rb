class Admins::DashboardController < Admins::BaseController

  def index
		@total_articles = Article.count
		@total_careers = Career.count
		@total_portfolios = Portfolio.count
		@total_inguiries = Inquiry.count
  end

end
