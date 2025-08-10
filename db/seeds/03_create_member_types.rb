# CREATE Member Type
MemberType.delete_all

@mt1 = MemberType.create(name: "Board of Directors")
Mobility.with_locale(:id) {
	@mt1.name = "Dewan Direksi"
}
@mt1.save
puts "Create Member Type: #{@mt1.name}"

@mt2 = MemberType.create(name: "Executive Team")
Mobility.with_locale(:id) {
	@mt2.name = "Tim Eksekutif"
}
@mt2.save
puts "Create Member Type: #{@mt2.name}"

