# create about_desc
about_desc = Snippet.new(name: "about_desc")
about_desc.short_description = "WE ARE AN INDEPENDENT ENERGY COMPANY ENGAGED IN THE ENERGY BUSINESS WITH OPERATIONS PRIMARILY IN INDONESIA."
about_desc.description = "Our strategy is to build an oil and gas assets portfolio with an optimum mix between medium-sized producing blocks and exploration blocks with significant potential resources."
about_desc.template = "info_description"
Mobility.with_locale(:cn) {
	about_desc.short_description = "我们是一家从事能源业务的独立能源公司，主要在印度尼西亚开展业务。"
	about_desc.description = "我们的战略是建立一个油气资产组合，在中型生产区块和具有大量潜在资源的勘探区块之间实现最佳组合。"
}
about_desc.save
Section.create(page_id: @about_page.id, snippet_id: about_desc.id, css_class: "small-section pb-0", order_no: 1)
puts "Create Snippet: #{about_desc.name}"

# create mission
mission = Snippet.new(name: "mission")
mission.title = "Our Mission"
mission.short_description = "Our mission is to efficiently manage targeted profitable energy resources in Indonesia by executing sustainable projects with excellence. This strategy allows us to maintain a sustainable oil and gas upstream business and should generate excess returns on investment along with reducing risk exposure."
mission.template = "call_to_action2"
mission.css_desc = "w-70 sm-w-100"
mission.image.attach(io: Rails.root.join("vendor/assets/images/banners/banner-mission.png").open, filename: "banner-mission.png")
Mobility.with_locale(:cn) {
	mission.title = "我们的任务"
	mission.short_description = "我们的使命是通过卓越执行可持续项目，有效管理印度尼西亚的目标盈利能源。这一战略使我们能够维持可持续的石油和天然气上游业务，并在减少风险敞口的同时产生超额投资回报。"
}
mission.save
Section.create(page_id: @about_page.id, snippet_id: mission.id, css_class: "small-section", order_no: 2)
puts "Create Snippet: #{mission.name}"

# create experience
experience = Snippet.new(name: "experience")
experience.title = "Our Experience"
experience.short_description = %q{
<p>Our management team members have extensive experience in petroleum exploration, development and production operations. Together they have successfully operated more than 17 oil and gas blocks and found and developed more than 10 oil and gas fields over the last 15 years.</p>
<p>Our recently added management team located in the United States consists of our President and Chief Financial Officer. Our President brings 40 years of public energy company experience and was the founder of two NYSE American listed energy companies. Our Chief Financial Officer brings 37 years of experience in finance, 15 of them in public companies.</p>
}
experience.template = "info_image2"
experience.orientation = "left"
experience.title_tag = "h5"
experience.image.attach(io: Rails.root.join("vendor/assets/images/pictures/experience.png").open, filename: "experience.png")
Mobility.with_locale(:cn) {
	experience.title = "我们的经验"
	experience.short_description = %q{
		<p>我们的管理团队成员在石油勘探、开发和生产运营方面拥有丰富的经验。在过去 15 年里，他们共同成功运营了超过 17 个油气区块，并发现和开发了 10 多个油气田。</p>
		<p>我们最近在美国增加的管理团队由总裁和首席财务官组成。我们的总裁拥有 40 年的公共能源公司经验，是两家在纽约证券交易所美国上市的能源公司的创始人。我们的首席财务官拥有 37 年的金融经验，其中 15 年在上市公司工作。</p>
	}
}
experience.save
Section.create(page_id: @about_page.id, snippet_id: experience.id, css_class: "small-section pt-0", order_no: 3)
puts "Create Snippet: #{experience.name}"

# create approach
approach = Snippet.new(name: "approach")
approach.title = "Our Approach"
approach.short_description = %q{
<p>Led by a professional management team with extensive oil and gas experience, we seek to bring forth the best of our expertise to ensure the sustainable development of a profitable and integrated energy exploration and production business model.</p>
<p>Alongside operational excellence, we believe we have set the highest standards for ethics, safety and corporate social responsibility practices to ensure that we add value to society. With this approach, we are able to attract the best opportunities and execute projects with excellence.</p>
}
approach.template = "info_image2"
approach.orientation = "left"
approach.title_tag = "h5"
approach.image.attach(io: Rails.root.join("vendor/assets/images/pictures/approach.png").open, filename: "approach.png")
Mobility.with_locale(:cn) {
	approach.title = "我们的方法"
	approach.short_description = %q{
		<p>在拥有丰富石油和天然气经验的专业管理团队的领导下，我们力求发挥最好的专业知识，以确保盈利和综合能源勘探和生产业务模式的可持续发展。</p>
		<p>除了卓越运营之外，我们相信我们还制定了道德、安全和企业社会责任实践的最高标准，以确保我们为社会增加价值。通过这种方法，我们能够吸引最好的机会并卓越地执行项目。</p>
	}
}
approach.save
Section.create(page_id: @about_page.id, snippet_id: approach.id, css_class: "small-section", order_no: 4)
puts "Create Snippet: #{approach.name}"

# create members
members = Snippet.new(name: "members")
members.save
Section.create(page_id: @about_page.id, snippet_id: members.id, bg_color: "bg-grey", css_class: "small-section", order_no: 5)
puts "Create Snippet: #{members.name}"

# assign contact_us
Section.create(page_id: @about_page.id, snippet_id: @contact_us.id, css_class: "half-section", order_no: 6)
puts "Assign Snippet: #{@contact_us.name}"
