# Create Subsidiaries
Portfolio.delete_all
puts "Create Portfolios data"

@sumatra_kruh = Portfolio.new(name: "Sumatra Kruh Block", company_name: "Indonesia Energy Corp.", page: @sumatra_kruh_page)
@sumatra_kruh.description = "Kruh Block covers an area of 258 square kilo meters (63,753 acres) in Sumatra, Indonesia. This block produced an average of about 9,900 barrels of oil per month (gross) in 2018."
@sumatra_kruh.image.attach(io: Rails.root.join("vendor/assets/images/portfolios/sumatra-kruh.png").open, filename: "sumatra-kruh.png")
Mobility.with_locale(:cn) {
	@sumatra_kruh.name = "苏门答腊克鲁块"
	@sumatra_kruh.description = "Kruh 区块位于印度尼西亚苏门答腊岛，占地 258 平方公里（63,753 英亩）。 2018 年，该区块平均每月生产约 9,900 桶石油（总量）。"
}
@sumatra_kruh.save

@java_citarum = Portfolio.new(name: "Java Citarum Block", company_name: "Indonesia Energy Corp.", page: @java_citarum_page)
@java_citarum.description = "Citarum is a gas prone block covering an area of 3,925 square kilo meters (969,807 acres) located just 16 miles south from Jakarta, Indonesia’s capital city."
@java_citarum.image.attach(io: Rails.root.join("vendor/assets/images/portfolios/java-citarum.png").open, filename: "java-citarum.png")
Mobility.with_locale(:cn) {
	@java_citarum.name = "爪哇柑橘块"
	@java_citarum.description = "Citarum 是一个易燃气体区块，占地 3,925 平方公里（969,807 英亩），位于印度尼西亚首都雅加达以南仅 16 英里。"
}
@java_citarum.save
