# create portfolio
portfolio = Snippet.new(name: "portfolio")
portfolio.save
Section.create(page_id: @portfolio_page.id, snippet_id: portfolio.id, css_class: "small-section", order_no: 1)
puts "Create Snippet: #{portfolio.name}"
