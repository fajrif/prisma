# create news_navigation
news_navigation = Snippet.new(name: "news_navigation")
news_navigation.caption = "News & Media"
Mobility.with_locale(:cn) {
	news_navigation.caption = "新闻媒体"
}
news_navigation.template = "tab_navigation"
news_navigation.save
link_button = news_navigation.link_buttons.build
link_button.route_category = 2
link_button.objectable = @press_release_page
link_button.link_text = "press_release"
link_button.save
link_button = news_navigation.link_buttons.build
link_button.route_category = 2
link_button.objectable = @media_page
link_button.link_text = "media_page"
link_button.save

Section.create(page_id: @press_release_page.id, snippet_id: news_navigation.id, css_class: "small-section", order_no: 1)
puts "Assign Snippet #{news_navigation.name} to Press Release"

Section.create(page_id: @press_release_page.id, snippet_id: @news.id, css_class: "half-section pt-0", order_no: 2)
puts "Assign Snippet #{@news.name} to Press Release"

# create videos
videos = Snippet.new(name: "videos")
videos.save

Section.create(page_id: @media_page.id, snippet_id: news_navigation.id, css_class: "small-section", order_no: 1)
puts "Assign Snippet #{news_navigation.name} to Media"

Section.create(page_id: @media_page.id, snippet_id: videos.id, css_class: "half-section pt-0", order_no: 2)
puts "Assign Snippet #{videos.name} to Media"
