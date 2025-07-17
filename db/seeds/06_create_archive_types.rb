# CREATE Archive Type
ArchiveType.delete_all

# Archive Type 1
@at1 = ArchiveType.create(name: "Company Profile")
Mobility.with_locale(:cn) {
	@at1.name = "公司简介"
}
@at1.save
puts "Create ArchiveType: #{@at1.name}"

# Archive Type 2
@at2 = ArchiveType.create(name: "Corporate Materials")
Mobility.with_locale(:cn) {
	@at2.name = "企业资料"
}
@at2.save
puts "Create ArchiveType: #{@at2.name}"
