# create board_committees
board_committees = Snippet.new(name: "board_committees")
board_committees.title = "Board Committees"
Mobility.with_locale(:cn) {
	board_committees.title = "董事会委员会"
}
board_committees.save

Section.create(page_id: @corporate_governance_page.id, snippet_id: board_committees.id, bg_color: "bg-grey", css_class: "half-section", order_no: 2)
puts "Assign Snippet #{board_committees.name} to Corporate Governance"

# create committee_charter
committee_charter = Snippet.new(name: "committee_charter")
committee_charter.title = "Committee Charter"
Mobility.with_locale(:cn) {
	committee_charter.title = "委员会章程"
}
committee_charter.save

Section.create(page_id: @corporate_governance_page.id, snippet_id: committee_charter.id, css_class: "half-section", order_no: 3)
puts "Assign Snippet #{committee_charter.name} to Corporate Governance"
