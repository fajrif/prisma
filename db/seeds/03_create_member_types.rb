# CREATE Member Type
MemberType.delete_all

@mt1 = MemberType.create(name: "Board of Directors")
Mobility.with_locale(:cn) {
	@mt1.name = "董事会"
}
@mt1.save
puts "Create Member Type: #{@mt1.name}"

@mt2 = MemberType.create(name: "Executive Team")
Mobility.with_locale(:cn) {
	@mt2.name = "高管团队"
}
@mt2.save
puts "Create Member Type: #{@mt2.name}"

