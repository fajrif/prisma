# Create Pages for Homepage
Page.delete_all

# Create Page 1
@home_page = Page.create(title: "Home", banner_section: @bs1)
puts "Create Page: #{@home_page.title}"

# Create Page 2
@about_page = Page.create(title: "About Us", banner_section: @bs2)
puts "Create Page: #{@about_page.title}"
