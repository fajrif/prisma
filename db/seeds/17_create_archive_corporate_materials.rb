# create corporate materials archive

# NOMINATING AND CORPORATE GOVERNANCE COMMITTEE CHARTER
@nominating_charter = Archive.new(title: "Nominating and Corporate Governance Committee Charter", archive_type: @at2)
@nominating_charter.file.attach(io: Rails.root.join("public/reports/prisma_archives/adopted-n-cg-committee-charter.pdf").open, filename: "adopted-n-cg-committee-charter.pdf")
Mobility.with_locale(:cn) {
	@nominating_charter.title = "提名和公司治理委员会章程"
}
@nominating_charter.published_date = DateTime.strptime('06/21/2019 2:46 AM', '%m/%d/%Y %I:%M %p')
@nominating_charter.save
puts "Create Archive: #{@nominating_charter.title}"

# CODE OF ETHICS
@code_ethics_file = Archive.new(title: "Code of Ethics", archive_type: @at2)
@code_ethics_file.file.attach(io: Rails.root.join("public/reports/prisma_archives/adopted-code-of-ethics.pdf").open, filename: "adopted-code-of-ethics.pdf")
Mobility.with_locale(:cn) {
	@code_ethics_file.title = "道德准则"
}
@code_ethics_file.published_date = DateTime.strptime('06/21/2019 1:46 AM', '%m/%d/%Y %I:%M %p')
@code_ethics_file.save
puts "Create Archive: #{@code_ethics_file.title}"

# COMPENSATION COMMITTEE CHARTER
@compensation_file = Archive.new(title: "Compensation Committee Charter", archive_type: @at2)
@compensation_file.file.attach(io: Rails.root.join("public/reports/prisma_archives/adopted-compensation-committee-charter.pdf").open, filename: "adopted-compensation-committee-charter.pdf")
Mobility.with_locale(:cn) {
	@compensation_file.title = "薪酬委员会章程"
}
@compensation_file.published_date = DateTime.strptime('06/21/2019 2:46 AM', '%m/%d/%Y %I:%M %p')
@compensation_file.save
puts "Create Archive: #{@compensation_file.title}"

# AUDIT COMITTEE
@audit_file = Archive.new(title: "Audit Committee Charter", archive_type: @at2)
@audit_file.file.attach(io: Rails.root.join("public/reports/prisma_archives/adopted-audit-committee-charter.pdf").open, filename: "adopted-audit-committee-charter.pdf")
Mobility.with_locale(:cn) {
	@audit_file.title = "审计委员会章程"
}
@audit_file.published_date = DateTime.strptime('06/21/2019 1:46 AM', '%m/%d/%Y %I:%M %p')
@audit_file.save
puts "Create Archive: #{@audit_file.title}"
