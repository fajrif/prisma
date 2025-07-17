# create about_sumatra_kruh
about_sumatra_kruh = Snippet.new(name: "about_sumatra_kruh")
about_sumatra_kruh.short_description = "Kruh Block covers an area of 258 square kilo meters (63,753 acres) in Sumatra, Indonesia. This block produced an average of about 9,900 barrels of oil per month (gross) in 2018."
about_sumatra_kruh.description = %q{
<p>Out of the total eight proved and potentially oil bearing structures in the block, three structures (North Kruh, Kruh and West Kruh fields) have combined proved developed and undeveloped gross crude oil reserves of 4.99 million barrels (net crude oil proved reserves of 2.13 million barrels) and probable undeveloped gross crude oil reserves of 2.59 million barrels (net probable crude oil reserves of 1.12 million barrels) as of January 1, 2019.</p>
<p>Our short-to-medium term objective is to ramp up production by drilling 18 new wells, to optimize the block’s upside potential and increase reserve values with seismic surveys.</p>
}
about_sumatra_kruh.template = "info_description"
Mobility.with_locale(:cn) {
	about_sumatra_kruh.short_description = "Kruh 区块位于印度尼西亚苏门答腊岛，占地 258 平方公里（63,753 英亩）。 2018 年，该区块平均每月生产约 9,900 桶石油（总量）。"
	about_sumatra_kruh.description = %q{
		<p>在该区块共有 8 个已探明和潜在含油构造中，其中 3 个构造（北克鲁、克鲁和西克鲁油田）已探明已开发和未开发原油总储量合计为 499 万桶（已探明净原油储量为 213 万桶）截至 2019 年 1 月 1 日，可能未开发原油总储量为 259 万桶（净可能原油储量为 112 万桶）。</p>
		<p>我们的中短期目标是通过钻探 18 口新井来提高产量，优化该区块的上行潜力，并通过地震勘探增加储量价值。</p>
	}
}
about_sumatra_kruh.save
Section.create(page_id: @sumatra_kruh_page.id, snippet_id: about_sumatra_kruh.id, css_class: "small-section pb-0", order_no: 1)
puts "Create Snippet: #{about_sumatra_kruh.name}"

# create sumatra_kruh_map
sumatra_kruh_map = Snippet.new(name: "sumatra_kruh_map")
sumatra_kruh_map.template = "display_image"
sumatra_kruh_map.image.attach(io: Rails.root.join("vendor/assets/images/diagrams/sumatra-kruh-map.png").open, filename: "sumatra-kruh-map.png")
sumatra_kruh_map.save
Section.create(page_id: @sumatra_kruh_page.id, snippet_id: sumatra_kruh_map.id, css_class: "small-section", order_no: 2)
puts "Create Snippet: #{sumatra_kruh_map.name}"

# create sumatra_kruh_video
sumatra_kruh_video = Snippet.new(name: "sumatra_kruh_video")
sumatra_kruh_video.short_description = "We hold 100% participating interest in Kruh Block. The block operates under a Technical Assistance Contract (TAC) with Pertamina, Indonesia’s state-owned oil and natural gas corporation, until May 2020 and the operatorship of Kruh Block will continue as a Joint Operation Partnership (KSO) from May 2020 until May 2030."
sumatra_kruh_video.image.attach(io: Rails.root.join("vendor/assets/images/videos/video_template.png").open, filename: "video_template.png")
sumatra_kruh_video.template = "info_image"
sumatra_kruh_video.orientation = "right"
sumatra_kruh_video.video_url = "https://www.youtube.com/watch?v=4gTNNXYRqzc"
Mobility.with_locale(:cn) {
	sumatra_kruh_video.short_description = "我们持有 Kruh Block 100% 的参与权益。该区块根据与印度尼西亚国有石油和天然气公司 Pertamina 签订的技术援助合同 (TAC) 运营，直至 2020 年 5 月，Kruh 区块的运营将从 2020 年 5 月至 2030 年 5 月继续作为联合运营合作伙伴关系 (KSO)。"
}
sumatra_kruh_video.save
Section.create(page_id: @sumatra_kruh_page.id, snippet_id: sumatra_kruh_video.id, css_class: "small-section", order_no: 3)
puts "Create Snippet: #{sumatra_kruh_video.name}"

# create sumatra_kruh_key_points
sumatra_kruh_key_points = Snippet.new(name: "sumatra_kruh_key_points")
sumatra_kruh_key_points.save
Section.create(page_id: @sumatra_kruh_page.id, snippet_id: sumatra_kruh_key_points.id, bg_color: "bg-green", css_class: "half-section", order_no: 4)
puts "Create Snippet: #{sumatra_kruh_key_points.name}"
