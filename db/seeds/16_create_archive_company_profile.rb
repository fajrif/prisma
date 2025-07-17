# Company Profile Archive

@compro_file = Archive.new(title: "Investor Presentation", archive_type: @at1)
@compro_file.file.attach(io: Rails.root.join("public/reports/prisma_archives/INDONESIAENERGYInvestorPresentationJan2022.pdf").open, filename: "INDONESIAENERGYInvestorPresentationJan2022.pdf")
Mobility.with_locale(:cn) {
	@compro_file.title = "投资者介绍"
}
@compro_file.save
puts "Create Archive: #{@compro_file.title}"
