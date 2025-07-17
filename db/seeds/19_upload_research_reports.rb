
# CREATE RESEARCH REPORT
report = Report.new(title: "Noble Capital Market Research Reports", report_type: @rt1)
report.author = @author1
report.file.attach(io: Rails.root.join("public/reports/research_reports/MichaelHeimNobleJan26Analystreport.pdf").open, filename: "MichaelHeimNobleJan26Analystreport.pdf")
Mobility.with_locale(:cn) {
	report.title = "Noble Capital Market 研究报告"
}
report.published_date = DateTime.strptime('01/26/2022 2:46 AM', '%m/%d/%Y %I:%M %p')
report.save
puts "Create Archive: #{report.title}"

report = Report.new(title: "Stonegate Capital Partners Research Reports", report_type: @rt1)
report.author = @author2
report.file.attach(io: Rails.root.join("public/reports/research_reports/MarcoRodriguezStonegateFeb3analystreport.pdf").open, filename: "MarcoRodriguezStonegateFeb3analystreport.pdf")
Mobility.with_locale(:cn) {
	report.title = "Stonegate Capital Partners 研究报告"
}
report.published_date = DateTime.strptime('02/03/2022 2:46 AM', '%m/%d/%Y %I:%M %p')
report.save
puts "Create Archive: #{report.title}"
