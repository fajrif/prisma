# Create Menus
#
require "json"

Menu.delete_all

puts "create menu header"
header_menu_en = File.read(Rails.root.join("public/menu/header_menu_en.json"))
header_menu_cn = File.read(Rails.root.join("public/menu/header_menu_cn.json"))
header = Menu.create(:section => 1, :data => header_menu_en)
Mobility.with_locale(:cn) {
	header.data = header_menu_cn
}
header.save

puts "create menu footer"
footer_menu_en = File.read(Rails.root.join("public/menu/footer_menu_en.json"))
footer_menu_cn = File.read(Rails.root.join("public/menu/footer_menu_cn.json"))
footer = Menu.create(:section => 2, :data => footer_menu_en)
Mobility.with_locale(:cn) {
	footer.data = footer_menu_cn
}
footer.save
