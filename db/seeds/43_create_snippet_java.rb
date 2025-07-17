# create about_java_citarum
about_java_citarum = Snippet.new(name: "about_java_citarum")
about_java_citarum.short_description = "Citarum is a gas prone block covering an area of 3,925 square kilo meters (969,807 acres) located just 16 miles south from Jakarta, Indonesia’s capital city."
about_java_citarum.description = %q{
<p>The region has been known to have a proven petroleum system due to its long history of exploration and production efforts since the 1960’s, where, currently, the combined oil fields produce a total of 45,000 BOPD and 450 MMSCFD.</p>
<p>In the past 10 years, 4 wells were drilled in different locations across the block and, providentially, all 4 wells discovered natural gas while gas flow was recorded in 2 of those wells. So far, more than US$ 40 million has already been invested in Citarum Block.</p>
}
about_java_citarum.template = "info_description"
Mobility.with_locale(:cn) {
	about_java_citarum.short_description = "Citarum 是一个易燃气体区块，占地 3,925 平方公里（969,807 英亩），位于印度尼西亚首都雅加达以南仅 16 英里。"
	about_java_citarum.description = %q{
		<p>该地区自 1960 年代以来一直致力于勘探和生产，拥有成熟的石油系统，目前，该地区的联合油田产量总计为 45,000 BOPD 和 450 MMSCFD。</p>
		<p>在过去的 10 年里，该区块的不同地点钻了 4 口井，幸运的是，所有 4 口井都发现了天然气，其中 2 口井还记录到了天然气流量。迄今为止，Citarum Block 已投资超过 4000 万美元。</p>
	}
}
about_java_citarum.save
Section.create(page_id: @java_citarum_page.id, snippet_id: about_java_citarum.id, css_class: "small-section pb-0", order_no: 1)
puts "Create Snippet: #{about_java_citarum.name}"

# create java_citarum_map
java_citarum_map = Snippet.new(name: "java_citarum_map")
java_citarum_map.template = "display_image"
java_citarum_map.image.attach(io: Rails.root.join("vendor/assets/images/diagrams/java-citarum-map.png").open, filename: "java-citarum-map.png")
java_citarum_map.save
Section.create(page_id: @java_citarum_page.id, snippet_id: java_citarum_map.id, css_class: "small-section", order_no: 2)
puts "Create Snippet: #{java_citarum_map.name}"

# create java_citarum_video
java_citarum_video = Snippet.new(name: "java_citarum_video")
java_citarum_video.short_description = "The results from the 4 wells drilled in Citarum and the amount of data available regarding the block are the key factors for us in selecting Citarum as the block’s risk profile was significantly reduced with the discovery of gas across the area."
java_citarum_video.image.attach(io: Rails.root.join("vendor/assets/images/videos/video_template.png").open, filename: "video_template.png")
java_citarum_video.template = "info_image"
java_citarum_video.orientation = "right"
java_citarum_video.video_url = "https://www.youtube.com/watch?v=4gTNNXYRqzc"
Mobility.with_locale(:cn) {
	java_citarum_video.short_description = "Citarum 钻探的 4 口井的结果以及该区块的可用数据量是我们选择 Citarum 的关键因素，因为随着该地区天然气的发现，该区块的风险状况显着降低。"
}
java_citarum_video.save
Section.create(page_id: @java_citarum_page.id, snippet_id: java_citarum_video.id, css_class: "small-section pb-0", order_no: 3)
puts "Create Snippet: #{java_citarum_video.name}"

# create info_java_citarum
info_java_citarum = Snippet.new(name: "info_java_citarum")
info_java_citarum.short_description = "Likewise, the fact that gas zones exist at different depths between 1,000 feet and 6,000 feet contributes to the potential of commercially developing these gas discoveries."
info_java_citarum.description = "Citarum Block is operated under a Production Sharing Contract (PSC) with the Government of Indonesia based on a “gross split” regime until July 2048."
info_java_citarum.template = "info_description"
Mobility.with_locale(:cn) {
	info_java_citarum.short_description = "同样，天然气带存在于 1,000 英尺至 6,000 英尺之间的不同深度，这一事实有助于提高这些天然气发现的商业开发潜力。"
	info_java_citarum.description = "Citarum Block 根据与印度尼西亚政府签订的生产分成合同 (PSC) 进行运营，该合同基于“总分割”制度，直至 2048 年 7 月。"
}
info_java_citarum.save
Section.create(page_id: @java_citarum_page.id, snippet_id: info_java_citarum.id, css_class: "small-section", order_no: 4)
puts "Create Snippet: #{info_java_citarum.name}"

# create java_citarum_key_points
java_citarum_key_points = Snippet.new(name: "java_citarum_key_points")
java_citarum_key_points.save
Section.create(page_id: @java_citarum_page.id, snippet_id: java_citarum_key_points.id, bg_color: "bg-green", css_class: "half-section", order_no: 5)
puts "Create Snippet: #{java_citarum_key_points.name}"
