# CREATE Report Type
ReportType.delete_all

# Report Type 1
@rt1 = ReportType.create(name: "Research Reports")
Mobility.with_locale(:cn) {
	@rt1.name = "研究报告"
}
@rt1.save
puts "Create ReportType: #{@rt1.name}"
