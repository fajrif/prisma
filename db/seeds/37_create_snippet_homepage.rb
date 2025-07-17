# Create Snippets
Snippet.delete_all

# create running_text
running_text = Snippet.new(name: "running_text")
running_text.title = "Powering Progress, Nurturing Nature: Our Energy, Your Future."
Mobility.with_locale(:cn) {
	running_text.title = "推动进步，培育自然：我们的能源，您的未来。"
}
running_text.save
Section.create(page_id: @home_page.id, snippet_id: running_text.id, css_class: "small-section", order_no: 1)
puts "Create Snippet: #{running_text.name}"

# create news
@news = Snippet.new(name: "news")
@news.title = "Latest Press Release"
@news.caption = "News & Media"
Mobility.with_locale(:cn) {
	@news.title = "最新新闻稿"
	@news.caption = "新闻媒体"
}
@news.save
Section.create(page_id: @home_page.id, snippet_id: @news.id, css_class: "small-section pt-0", order_no: 2)
puts "Create Snippet: #{@news.name}"

# create about_company
about_company = Snippet.new(name: "about_company")
about_company.title = "Our producing asset, Kruh Block, located in Pendopo, South Sumatra province, is a stable and positive cashflow generating oil asset"
about_company.template = "call_to_action2"
about_company.orientation = "center"
about_company.title_tag = "h3"
about_company.css_title = "w-100 sm-w-100"
about_company.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-about2.png").open, filename: "banner-about2.png")
Mobility.with_locale(:cn) {
	about_company.title = "我们的生产资产 Kruh 区块位于南苏门答腊省彭多波，是一项稳定且能产生正现金流的石油资产"
}
about_company.save
Section.create(page_id: @home_page.id, snippet_id: about_company.id, bg_color: "bg-black", css_class: "p-0", order_no: 3)
puts "Create Snippet: #{about_company.name}"

# create our_story
our_story = Snippet.new(name: "our_story")
our_story.title = "SUSTAINING NATURE: EMPOWERING PROGRESS"
our_story.caption = "Our Story"
our_story.short_description = %q{
<p>Our strategy is to build an oil and gas assets portfolio with an optimum mix between medium-sized producing blocks and exploration blocks with significant potential resources.</p>
}
our_story.template = "info_image"
our_story.orientation = "right"
our_story.image.attach(io: Rails.root.join("vendor/assets/images/pictures/our_story.png").open, filename: "our_story.png")
Mobility.with_locale(:cn) {
	our_story.title = "维持自然：推动进步"
	our_story.caption = "我们的故事"
	our_story.short_description = %q{
		<p>我们的战略是建立一个油气资产组合，在中型生产区块和具有大量潜在资源的勘探区块之间实现最佳组合。</p>
	}
}
our_story.save
link_button = our_story.link_buttons.build
link_button.route_category = 2
link_button.objectable = @about_page
link_button.link_text = "view_title"
link_button.save
Section.create(page_id: @home_page.id, snippet_id: our_story.id, bg_color: "bg-green", css_class: "half-section", order_no: 4)
puts "Create Snippet: #{our_story.name}"

# create sustainability
sustainability = Snippet.new(name: "sustainability")
sustainability.title = "Sustainability"
sustainability.short_description = "From the moment our company was established, we have been fully committed to contribute to the surrounding environment and the society."
sustainability.template = "call_to_action2"
sustainability.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-sustainability2.png").open, filename: "banner-sustainability2.png")
Mobility.with_locale(:cn) {
	sustainability.title = "可持续发展"
	sustainability.short_description = "从公司成立的那一刻起，我们就全力致力于为周围环境和社会做出贡献。"
}
sustainability.save
link_button = sustainability.link_buttons.build
link_button.route_category = 2
link_button.objectable = @sustainability_page
link_button.save
Section.create(page_id: @home_page.id, snippet_id: sustainability.id, css_class: "half-section", order_no: 5)
puts "Create Snippet: #{sustainability.name}"

# create locations
locations = Snippet.new(name: "locations")
locations.title = "Locations"
locations.caption = "Our Portfolio"
Mobility.with_locale(:cn) {
	locations.title = "地点"
	locations.caption = "我们的产品组合"
}
locations.save
link_button = locations.link_buttons.build
link_button.route_category = 2
link_button.objectable = @portfolio_page
link_button.link_text = "view_locations"
link_button.save
Section.create(page_id: @home_page.id, snippet_id: locations.id, css_class: "small-section pt-0", order_no: 6)
puts "Create Snippet: #{locations.name}"

# create media
media = Snippet.new(name: "media")
media.title = "News & Media"
media.caption = "Company Video"
Mobility.with_locale(:cn) {
	media.title = "新闻媒体"
	media.caption = "公司视频"
}
media.save
link_button = media.link_buttons.build
link_button.route_category = 2
link_button.objectable = @media_page
link_button.link_text = "view_media"
link_button.save
Section.create(page_id: @home_page.id, snippet_id: media.id, css_class: "half-section pt-0", order_no: 7)
puts "Create Snippet: #{media.name}"

# create presentation
presentation = Snippet.new(name: "presentation")
presentation.title = "INDONESIA ENERGY CORP (NYSE AMERICAN: INDO)"
presentation.template = "info_image"
presentation.orientation = "left"
presentation.title_tag = "h4"
presentation.image.attach(io: Rails.root.join("vendor/assets/images/pictures/prisma_presentation.png").open, filename: "prisma_presentation.png")
Mobility.with_locale(:cn) {
	presentation.title = "印度尼西亚能源公司（纽约证券交易所股票代码：INDO）"
}
presentation.save
link_button = presentation.link_buttons.build
link_button.route_category = 2
link_button.objectable = @compro_file
link_button.link_text = "view_title"
link_button.save
Section.create(page_id: @home_page.id, snippet_id: presentation.id, bg_color: "bg-green", css_class: "half-section", order_no: 8)
puts "Create Snippet: #{presentation.name}"

# create contact_us
@contact_us = Snippet.new(name: "contact_us")
@contact_us.title = "prisma – Indonesia Energy Corporation"
@contact_us.short_description = "Developing ENERGY RECOURCES in the western part of Indonesia"
@contact_us.template = "call_to_action1"
Mobility.with_locale(:cn) {
	@contact_us.title = "prisma——印度尼西亚能源公司"
	@contact_us.short_description = "开发印度尼西亚西部地区的能源资源"
}
@contact_us.save
link_button = @contact_us.link_buttons.build
link_button.route_category = 2
link_button.objectable = @contact_page
link_button.link_text = "contact_us"
link_button.save
Section.create(page_id: @home_page.id, snippet_id: @contact_us.id, css_class: "half-section", order_no: 9)
puts "Create Snippet: #{@contact_us.name}"
