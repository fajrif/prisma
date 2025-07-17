class Admins::DashboardController < Admins::BaseController

  def index
		@total_articles = Article.count
		@total_reports = Report.count
		@total_archives = Archive.count
		@total_inguiries = InvestorInquiry.count
  end

end
