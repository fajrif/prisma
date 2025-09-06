# Create Snippets
Snippet.delete_all

## create services_glance
services_glance = Snippet.new(name: "services_glance")
services_glance.title = "Our Services at a Glance"
services_glance.short_description = "We offer a complete suite of out-of-home media formats to power your brand presence, each designed to maximize visibility and performance."
Mobility.with_locale(:id) {
  services_glance.title = "Sekilas Tentang Layanan Kami"
  services_glance.short_description = "Menghadirkan solusi media luar ruang yang menggabungkan kualitas premium, inovasi kreatif, dan pendekatan strategis. Dari billboard statis hingga media digital interaktif, kami bantu brand Anda tampil berani dan berdampak."
}
services_glance.save

Section.create(page_id: @home_page.id, snippet_id: services_glance.id, bg_color: "bg-grey", order_no: 1)
puts "create Snippet: #{services_glance.name}"

## create billboard_locations
billboard_locations = Snippet.new(name: "billboard_locations")
billboard_locations.title = "Digital Billboard Locations"
billboard_locations.short_description = "Our digital billboards offer optimal placement in high-traffic areas all around Jakarta and beyond. Each location delivers powerful reach and engagement, ensuring maximum visibility for your campaigns."
Mobility.with_locale(:id) {
  billboard_locations.title = "Lokasi Papan Iklan Digital"
  billboard_locations.short_description = "Papan iklan digital kami menawarkan lokasi paling strategis di Jakarta dan sekitarnya. Setiap lokasi memiliki nilai dan daya tarik unik untuk memaksimalkan visibilitas brand Anda."
}
billboard_locations.save

Section.create(page_id: @home_page.id, snippet_id: billboard_locations.id, css_class: "half-section", order_no: 2)
puts "create Snippet: #{billboard_locations.name}"

## create innovative_solutions
innovative_solutions = Snippet.new(name: "innovative_solutions")
innovative_solutions.title = "Innovative Digital OOH Solutions"
innovative_solutions.short_description = "Browse through our range of DOOH Innovations and find the best one that fits your campaign."
innovative_solutions.image.attach(io: Rails.root.join("public/services/logo-ooh.png").open, filename: "logo-ooh.png")
innovative_solutions.background.attach(io: Rails.root.join("public/services/bg-ooh.png").open, filename: "bg-ooh.png")
Mobility.with_locale(:id) {
  innovative_solutions.title = "Solusi Inovatif OOH Digital"
  innovative_solutions.short_description = "Pelajari berbagai jenis media DOOH yang kami tawarkan dan temukan yang terbaik untuk brand Anda."
}
innovative_solutions.save

link_button = innovative_solutions.link_buttons.build
link_button.route_category = 1
link_button.link_text = "read_more"
link_button.save

Section.create(page_id: @home_page.id, snippet_id: innovative_solutions.id, order_no: 3)
puts "create Snippet: #{innovative_solutions.name}"

## create our_portfolios
our_portfolios = Snippet.new(name: "our_portfolios")
our_portfolios.title = "Our Campaign Portfolio"
our_portfolios.short_description = "Discover how leading brands have brought their campaigns to life through our premium OOH advertising services."
Mobility.with_locale(:id) {
  our_portfolios.title = "Portofolio Kampanye Kami"
  our_portfolios.short_description = "Temukan bagaimana kampanye dari berbagai brand ternama menjadi hidup melalui layanan iklan OOH premium dari kami."
}
our_portfolios.save

Section.create(page_id: @home_page.id, snippet_id: our_portfolios.id, order_no: 4)
puts "create Snippet: #{our_portfolios.name}"

## create our_industries
our_industries = Snippet.new(name: "our_industries")
our_industries.title = "Industries We Serve"
our_industries.short_description = "We have served clients from a broad spectrum of industries, successfully realizing each brand's vision through high-impact campaigns. No matter the sector, we have unmatched experience in making your message stand out."
our_industries.image.attach(io: Rails.root.join("public/images/prism.png").open, filename: "prism.png")
our_industries.background.attach(io: Rails.root.join("public/background/bg-industry.png").open, filename: "bg-industry.png")
Mobility.with_locale(:id) {
  our_industries.title = "Industri yang Kami Layani"
  our_industries.short_description = "Kami sudah bekerjasama dengan klien dari berbagai industri dan berhasil mendukung visi mereka dengan menyalurkan pesan yang memikat melalui iklan yang berdampak."
}
our_industries.save

Section.create(page_id: @home_page.id, snippet_id: our_industries.id, bg_color: "bg-image", css_class: "half-section", order_no: 5)
puts "create Snippet: #{our_industries.name}"

## create our_industries
our_clients = Snippet.new(name: "our_clients")
our_clients.save

Section.create(page_id: @home_page.id, snippet_id: our_clients.id, css_class: "pt-0 pb-0", order_no: 6)
puts "create Snippet: #{our_clients.name}"

## create testimonials
testimonials = Snippet.new(name: "testimonials")
testimonials.title = "Testimonials"
testimonials.short_description = "Get insights from brands who trust us to deliver."
Mobility.with_locale(:id) {
  testimonials.title = "Testimoni"
  testimonials.short_description = "Dapatkan kesan dari brand yang sudah mempercayai kami."
}
testimonials.save

Section.create(page_id: @home_page.id, snippet_id: testimonials.id, bg_color: "bg-grey", order_no: 7)
puts "create Snippet: #{testimonials.name}"

## create about_company
about_company = Snippet.new(name: "about_company")
about_company.template = "info_image_left"
about_company.short_description = %q{
  <p>Prisma Ads is a leading Out-of-Home (OOH) advertising company in Indonesia, delivering impactful campaigns through strategically placed digital and static media.</p>
  <p>With a commitment to innovative OOH, reliability, and client success, we help brands connect with audiences where it matters most.</p>
}
about_company.image.attach(io: Rails.root.join("public/images/about-prisma.png").open, filename: "about-prisma.png")
about_company.background.attach(io: Rails.root.join("public/background/bg-info-2.png").open, filename: "bg-info-2.png")
Mobility.with_locale(:id) {
	about_company.short_description = %q{
    <p>Prisma adalah perusahaan penyedia jasa periklanan luar ruang (OOH) terkemuka di Indonesia.</p>
    <p>Dengan inovasi termajukan, kami terus menghadirkan iklan yang berdampak melalui berbagai media statis dan digital. Lokasi yang strategis juga mendukung kami dalam menjangkau audiens secara efektif dan memberikan kampanye yang bermakna.</p>
  }
}
about_company.css_desc = "title-small font-weight-500"
about_company.save
link_button = about_company.link_buttons.build
link_button.route_category = 2
link_button.objectable = @about_page
link_button.link_text = "view_title"
link_button.save

Section.create(page_id: @home_page.id, snippet_id: about_company.id, order_no: 8)
puts "create Snippet: #{about_company.name}"

## create testimonials
blogs = Snippet.new(name: "blogs")
blogs.title = "Blog"
blogs.short_description = "Browse through our collection of editorial insights, industry trends, and expert perspectives on OOH advertising."
Mobility.with_locale(:id) {
  blogs.title = "Blog"
  blogs.short_description = "Jelajahi kumpulan artikel, tren industri, dan sudut pandang para ahli seputar dunia periklanan luar ruang (OOH)."
}
blogs.save

Section.create(page_id: @home_page.id, snippet_id: blogs.id, order_no: 9)
puts "create Snippet: #{blogs.name}"

## create career_cta
career_cta = Snippet.new(name: "career_cta")
career_cta.template = "call_to_action1"
career_cta.title = "Careers"
career_cta.caption = "Your Next Opportunity Starts Here"
career_cta.short_description = "We're always looking for driven, creative minds to help shape the future of OOH advertising. Grow with us and make an impact."
Mobility.with_locale(:id) {
  career_cta.title = "Karir"
  career_cta.caption = "Temukan kesempatan karir bersama Prisma disini."
  career_cta.short_description = "Di Prisma, kami percaya pada potensi kreativitas tanpa batas. Kami terbuka bagi siapa pun yang ingin bertumbuh dan memberi dampak bersama."
}
career_cta.save
link_button = career_cta.link_buttons.build
link_button.route_category = 1
link_button.link_text = "view_title"
link_button.link_url = "/careers"
link_button.save

Section.create(page_id: @home_page.id, snippet_id: career_cta.id, order_no: 10)
puts "create Snippet: #{career_cta.name}"
