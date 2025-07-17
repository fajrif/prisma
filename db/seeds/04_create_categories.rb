# CREATE Category
Category.delete_all

# Article Category 1
@cat1 = Category.create(name: "Press Release")
Mobility.with_locale(:cn) {
	@cat1.name = "新闻稿"
}
@cat1.save
puts "Create Category: #{@cat1.name}"

# Article Category 2
@cat2 = Category.create(name: "Media")
Mobility.with_locale(:cn) {
	@cat2.name = "媒体"
}
@cat2.save
puts "Create Category: #{@cat2.name}"
