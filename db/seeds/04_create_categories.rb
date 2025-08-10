# CREATE Category
Category.delete_all

# Article Category 1
@cat1 = Category.create(name: "OOH branding")
Mobility.with_locale(:id) {
	@cat1.name = "OOH branding"
}
@cat1.save
puts "Create Category: #{@cat1.name}"

# Article Category 2
@cat2 = Category.create(name: "Static Billboard Advertising")
Mobility.with_locale(:id) {
	@cat2.name = "Static Billboard Advertising"
}
@cat2.save
puts "Create Category: #{@cat2.name}"
