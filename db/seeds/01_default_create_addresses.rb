Address.delete_all
puts "create addresses"

addresses = [{
	en: "Headquarters",
	cn: "总部",
	address: "GIESMART PLAZA<br/>Jl. Raya Pasar Minggu No.17A 7<br/>Jakarta, Indonesia<br/>12780",
	email1: "info@indo-energy.com",
	phone1: "(+62) 21 576 8888",
	fax: "(+62) 21 576 1009"
}, {
	en: "US Office",
	cn: "美国办事处",
	address: "4115 Blackhawk Plaza<br/>CircleSuite 100Danville,<br/> CA 94506 USA"
}]

addresses.each_with_index do |adr, i|
	address = Address.new(name: adr[:en], complete_address: adr[:address], order_no: i+1)
	address.email1 = adr[:email1] if adr[:email1]
	address.phone1 = adr[:phone1] if adr[:phone1]
	address.fax = adr[:fax] if adr[:fax]
	Mobility.with_locale(:cn) {
		address.name = adr[:cn]
	}
	address.save
	puts "Create address: #{address.name}"
end
