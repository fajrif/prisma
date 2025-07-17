# create about_sustainability
about_sustainability = Snippet.new(name: "about_sustainability")
about_sustainability.title = "From the moment our company was established, we have been fully committed to contribute to the surrounding environment and the society."
about_sustainability.template = "info_image"
about_sustainability.orientation = "right"
about_sustainability.title_tag = "h4"
about_sustainability.image.attach(io: Rails.root.join("vendor/assets/images/pictures/info_sustainability.png").open, filename: "info_sustainability.png")
Mobility.with_locale(:cn) {
	about_sustainability.title = "从公司成立的那一刻起，我们就全力致力于为周围环境和社会做出贡献。"
}
about_sustainability.save
Section.create(page_id: @sustainability_page.id, snippet_id: about_sustainability.id, css_class: "small-section", order_no: 1)
puts "Create Snippet: #{about_sustainability.name}"

# create info_sustainability
info_sustainability = Snippet.new(name: "info_sustainability")
info_sustainability.short_description = "We want the society that feel they benefit from our presence. We believe a sustainable and mutually beneficial partnership with the society brings benefit to our company’s operations. For that reason, our company has arranged funding assistance to develop and repair public infrastructures nearby our sites such as for roads and bridges. We also pay a special attention to empower the local community in various Corporate Social Responsibility projects."
info_sustainability.description = "We are committed into the Tripple Bottom Line: “people, planet, and profit“, which recommends that companies must commit to focus on social as well as environmental concerns just as they do on profits. This commitment has been implemented in various programs for the enhancement of the society’s welfare, healthcare and education."
info_sustainability.template = "info_description"
Mobility.with_locale(:cn) {
	info_sustainability.short_description = "我们希望社会感到他们从我们的存在中受益。我们相信与社会建立可持续、互惠互利的伙伴关系将为我们公司的运营带来好处。因此，我们公司已安排资金援助，用于开发和修复我们工厂附近的道路和桥梁等公共基础设施。我们还特别注重在各种企业社会责任项目中为当地社区提供支持。"
	info_sustainability.description = "我们致力于三重底线：“人、地球和利润”，这建议公司必须致力于关注社会和环境问题，就像关注利润一样。这一承诺已在各种旨在提高社会福利、医疗保健和教育的项目中得到落实。"
}
info_sustainability.save
Section.create(page_id: @sustainability_page.id, snippet_id: info_sustainability.id, css_class: "small-section pt-0", order_no: 2)
puts "Create Snippet: #{info_sustainability.name}"
