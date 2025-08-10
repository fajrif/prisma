# CREATE Archive Type
ArchiveType.delete_all

# Archive Type 1
@at1 = ArchiveType.create(name: "Company Profile")
Mobility.with_locale(:id) {
	@at1.name = "Profil Perusahaan"
}
@at1.save
puts "Create ArchiveType: #{@at1.name}"
