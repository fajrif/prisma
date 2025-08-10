Address.delete_all
puts "create addresses"

addresses = [{
	en: "Headquarters",
	id: "Kantor Pusat",
  address: "GRAHA PRISMA<br/>Jl. Kedoya Duri Raya No.38,Kedoya Selatan,<br/>Jakarta Barat, 11520 - Indonesia",
	email1: "sales@prisma-ads.com",
	phone1: "+62 21 5835 6575",
	phone2: "+62 21 5835 6570",
	latitude: "-6.1837826477428885",
	longitude: "106.76723740972922"
}]

addresses.each_with_index do |adr, i|
	address = Address.new(name: adr[:en], complete_address: adr[:address], order_no: i+1)
	address.email1 = adr[:email1] if adr[:email1]
	address.phone1 = adr[:phone1] if adr[:phone1]
	address.phone2 = adr[:phone2] if adr[:phone2]
	address.latitude = adr[:latitude] if adr[:latitude]
	address.longitude = adr[:longitude] if adr[:longitude]
	Mobility.with_locale(:id) {
		address.name = adr[:id]
	}
	address.save
	puts "Create address: #{address.name}"
end
