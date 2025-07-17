# create research_reports
research_reports = Snippet.new(name: "research_reports")
research_reports.save

Section.create(page_id: @research_reports_page.id, snippet_id: research_reports.id, css_class: "half-section pt-0", order_no: 2)
puts "Assign Snippet #{research_reports.name} to Research Reports"
