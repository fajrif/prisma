# Create Banners for All Pages

Banner.delete_all

banner = Banner.new(title: "Indonesia’s Premier Emerging Energy Group", description: "We are an independent energy company bringing Indonesian Energy to the World")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-homepage.png").open, filename: "banner-homepage.png")
banner.banner_section = @bs1
Mobility.with_locale(:cn) {
	banner.title = "印度尼西亚首屈一指的新兴能源集团"
	banner.description = "我们是一家独立的能源公司，将印度尼西亚能源推向世界"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Meet our team of<br/>Industry Experts")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-about.png").open, filename: "banner-about.png")
banner.banner_section = @bs2
Mobility.with_locale(:cn) {
	banner.title = "认识我们的团队 <br/>行业专家"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Our Portfolio")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-portfolio.png").open, filename: "banner-portfolio.png")
banner.banner_section = @bs3
Mobility.with_locale(:cn) {
	banner.title = "我们的产品组合"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Sustainability")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-sustainability.png").open, filename: "banner-sustainability.png")
banner.banner_section = @bs4
Mobility.with_locale(:cn) {
	banner.title = "我们的产品组合"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Investor Relations")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-investor-relations.png").open, filename: "banner-investor-relations.png")
banner.banner_section = @bs5
Mobility.with_locale(:cn) {
	banner.title = "投资者关系"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Research Reports")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-investor-relations.png").open, filename: "banner-investor-relations.png")
banner.banner_section = @bs6
Mobility.with_locale(:cn) {
	banner.title = "研究报告"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Corporate Governance")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-investor-relations.png").open, filename: "banner-investor-relations.png")
banner.banner_section = @bs7
Mobility.with_locale(:cn) {
	banner.title = "公司治理"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Sumatra Kruh Block")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-sumatra-kruh.png").open, filename: "banner-sumatra-kruh.png")
banner.banner_section = @bs8
Mobility.with_locale(:cn) {
	banner.title = "苏门答腊克鲁块"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Java Citarum Block")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-java-citarum.png").open, filename: "banner-java-citarum.png")
banner.banner_section = @bs9
Mobility.with_locale(:cn) {
	banner.title = "爪哇柑橘块"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "News & Media", description: "Latest News, Insight and Our Publication")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-news-media.png").open, filename: "banner-news-media.png")
banner.banner_section = @bs10
Mobility.with_locale(:cn) {
	banner.title = "新闻媒体"
	banner.description = "最新消息、见解和我们的出版物"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "News & Media", description: "Latest News, Insight and Our Publication")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-news-media.png").open, filename: "banner-news-media.png")
banner.banner_section = @bs11
Mobility.with_locale(:cn) {
	banner.title = "新闻媒体"
	banner.description = "最新消息、见解和我们的出版物"
}
banner.save
puts "Create Banner: #{banner.title}"

banner = Banner.new(title: "Contact Us", description: "Lets talk, We’re ready to listen")
banner.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-indo-energy.png").open, filename: "banner-indo-energy.png")
banner.banner_section = @bs12
Mobility.with_locale(:cn) {
	banner.title = "联系我们"
	banner.description = "让我们谈谈，我们准备好倾听"
}
banner.save
puts "Create Banner: #{banner.title}"
