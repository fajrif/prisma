# create contact_info
contact_info = Snippet.new(name: "contact_info")
contact_info.save

Section.create(page_id: @contact_page.id, snippet_id: contact_info.id, css_class: "half-section pb-0")
puts "Assign Snippet #{contact_info.name} to Contact"

# create contact_form
contact_form = Snippet.new(name: "contact_form")
contact_form.save

Section.create(page_id: @contact_page.id, snippet_id: contact_form.id, bg_color: "bg-grey", css_class: "half-section")
puts "Assign Snippet #{contact_form.name} to Contact"
