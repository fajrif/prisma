# create news_navigation
investor_navigation = Snippet.new(name: "investor_navigation")
investor_navigation.caption = "Investor Overview"
Mobility.with_locale(:cn) {
	investor_navigation.caption = "投资者概览"
}
investor_navigation.template = "tab_navigation"
investor_navigation.save
link_button = investor_navigation.link_buttons.build
link_button.route_category = 2
link_button.objectable = @investor_relations_page
link_button.link_text = "sec_filings"
link_button.save
link_button = investor_navigation.link_buttons.build
link_button.route_category = 2
link_button.objectable = @research_reports_page
link_button.link_text = "research_reports"
link_button.save
link_button = investor_navigation.link_buttons.build
link_button.route_category = 2
link_button.objectable = @corporate_governance_page
link_button.link_text = "corporate_governance"
link_button.save

Section.create(page_id: @investor_relations_page.id, snippet_id: investor_navigation.id, css_class: "small-section", order_no: 1)
puts "Assign Snippet #{investor_navigation.name} to Investor Relations"

Section.create(page_id: @research_reports_page.id, snippet_id: investor_navigation.id, css_class: "small-section", order_no: 1)
puts "Assign Snippet #{investor_navigation.name} to Research Reports"

Section.create(page_id: @corporate_governance_page.id, snippet_id: investor_navigation.id, css_class: "small-section", order_no: 1)
puts "Assign Snippet #{investor_navigation.name} to Corporate Governance"
