# Create Pages for Homepage
Page.delete_all

# Create Page 1
@home_page = Page.create(title: "Home", banner_section: @bs1)
puts "Create Page: #{@home_page.title}"

# Create Page 2
@about_page = Page.create(title: "About Us", banner_section: @bs2)
puts "Create Page: #{@about_page.title}"

# Create Page 3
@portfolio_page = Page.create(title: "Portfolio", banner_section: @bs3)
puts "Create Page: #{@portfolio_page.title}"

# Create Page 4
@sustainability_page = Page.create(title: "Sustainability", banner_section: @bs4)
puts "Create Page: #{@sustainability_page.title}"

# Create Page 5
@investor_relations_page = Page.create(title: "Investor Relations", banner_section: @bs5)
puts "Create Page: #{@investor_relations_page.title}"

# Create Page 6
@research_reports_page = Page.create(title: "Research Reports", banner_section: @bs6)
puts "Create Page: #{@research_reports_page.title}"

# Create Page 7
@corporate_governance_page = Page.create(title: "Corporate Governance", banner_section: @bs7)
puts "Create Page: #{@corporate_governance_page.title}"

# Create Page 8
@sumatra_kruh_page = Page.create(title: "Sumatra Kruh", banner_section: @bs8)
puts "Create Page: #{@sumatra_kruh_page.title}"

# Create Page 9
@java_citarum_page = Page.create(title: "Java Citarum", banner_section: @bs9)
puts "Create Page: #{@java_citarum_page.title}"

# Create Page 10
@press_release_page = Page.create(title: "Press Release", banner_section: @bs10)
puts "Create Page: #{@press_release_page.title}"

# Create Page 11
@media_page = Page.create(title: "Media", banner_section: @bs11)
puts "Create Page: #{@media_page.title}"

# Create Page 12
@contact_page = Page.create(title: "Contact Us", banner_section: @bs12)
puts "Create Page: #{@contact_page.title}"

