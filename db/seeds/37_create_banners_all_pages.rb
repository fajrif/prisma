# Create Banners for All Pages
Banner.delete_all

# banner 1
banner = Banner.new(title: "Introducing Our New BRIN Grande LED in Gatot Subroto")
banner.description = "Our animation studio brings ideas to life with 3D animation, CGI, and 4D visuals, made for digital billboard and digital out-of-home advertising."
banner.image.attach(io: Rails.root.join("public/banners/banner-home-1.png").open, filename: "banner-home-1.png")
banner.banner_section = @bs1
Mobility.with_locale(:id) {
	banner.title = "Partner Reklame Billboard & Media Luar Ruang (OOH) Terkemuka di Indonesia"
	banner.description = "Solusi terpercaya untuk reklame billboard, iklan transportasi, dan berbagai jenis-jenis reklame lainnya. Prisma Ads hadir sebagai pionir media OOH di Indonesia, membantu brand tampil mencolok di ruang publik."
}
banner.save
puts "Create Banner: #{banner.title}"

# banner 2
banner = Banner.new(title: "Trusted by Leading Brands to Deliver Outdoor Impact")
banner.description = "Explore how top brands achieve results through creative billboard advertising, DOOH solutions, and LED billboard innovation."
banner.image.attach(io: Rails.root.join("public/banners/banner-home-2.png").open, filename: "banner-home-2.png")
banner.banner_section = @bs1
Mobility.with_locale(:id) {
	banner.title = "Dipercaya Brand Ternama untuk Meningkatkan Dampak Reklame OOH"
	banner.description = "Lihat bagaimana brand-brand besar memanfaatkan iklan billboard dan media luar ruang untuk membangun koneksi lebih luas dengan audiens mereka. Kami mendorong evolusi OOH dan DOOH melalui pendekatan kreatif dan teknologi terkini."
}
banner.save
puts "Create Banner: #{banner.title}"

# banner 3
banner = Banner.new(title: "Introducing Our New BRIN Grande LED in Gatot Subroto")
banner.description = "Commanding attention in one of Jakarta’s busiest arteries, this towering new LED screen delivers unmatched visibility and bold digital presence at the core of the capital’s commercial district."
banner.image.attach(io: Rails.root.join("public/banners/banner-home-3.png").open, filename: "banner-home-3.png")
banner.banner_section = @bs1
Mobility.with_locale(:id) {
	banner.title = "BRIN Grande LED Terbaru Kini Hadir di Gatot Subroto"
	banner.description = "Menarik perhatian di salah satu jalur tersibuk Jakarta, layar LED raksasa terbaru ini menghadirkan visibilitas yang luar biasa dan kehadiran digital yang kuat di jantung kawasan komersial ibu kota."
}
banner.save
puts "Create Banner: #{banner.title}"

# banner about
banner = Banner.new(title: "Shaping the Future of Out-of-Home Advertising in Indonesia")
banner.description = "Connect brands with the right audience at the right time with Prisma Advertising"
banner.image.attach(io: Rails.root.join("public/banners/banner-about.png").open, filename: "banner-about.png")
banner.banner_section = @bs2
Mobility.with_locale(:id) {
	banner.title = "Membangun Masa Depan Periklanan Out-of-Home di Indonesia"
	banner.description = "Bersama Prisma Advertising, hubungkan brand dengan audiens yang tepat di waktu yang tepat"
}
banner.save
puts "Create Banner: #{banner.title}"

# banner portfolio
banner = Banner.new(title: "Campaigns that Deliver")
banner.description = "See how our tailored strategies and premium placements bring brand stories to life with results that speak volumes."
banner.image.attach(io: Rails.root.join("public/banners/banner-portfolio.png").open, filename: "banner-portfolio.png")
banner.banner_section = @bs3
Mobility.with_locale(:id) {
	banner.title = "Iklan yang Memberikan Hasil"
	banner.description = "Lihat bagaimana strategi dan penempatan premium kami membawa narasi brand Anda menjadi hidup dengan hasil yang nyata."
}
banner.save
puts "Create Banner: #{banner.title}"

# banner services
banner = Banner.new(title: "Bring Your Ideas to Life with Premium OOH Solutions")
banner.description = "We turn creative concepts into striking out-of-home experiences."
banner.image.attach(io: Rails.root.join("public/banners/banner-services.png").open, filename: "banner-services.png")
banner.banner_section = @bs4
Mobility.with_locale(:id) {
	banner.title = "Hidupkan Ide Kreatif Anda Bersama Solusi Iklan OOH Premium"
	banner.description = "Kami mengubah ide kreatif menjadi pengalaman iklan luar ruang yang luar biasa."
}
banner.save
puts "Create Banner: #{banner.title}"

# banner industries
banner = Banner.new(title: "Your Industry, Our Expertise")
banner.description = "We bring targeted, high-performing OOH strategies to brands across sectors."
banner.image.attach(io: Rails.root.join("public/banners/banner-industries.png").open, filename: "banner-industries.png")
banner.banner_section = @bs5
Mobility.with_locale(:id) {
	banner.title = "Industri Anda, Keahlian Kami"
	banner.description = "Kami memberikan strategi OOH yang terarah dan berkinerja tinggi untuk berbagai sektor brand."
}
banner.save
puts "Create Banner: #{banner.title}"

# banner career
banner = Banner.new(title: "Shape What the World Sees Next")
banner.description = "Be part of a team that turns bold ideas into public experiences. At Prisma Advertising, we’re redefining what out-of-home and integrated media can do, creating campaigns that move beyond screens and into streets, cities, and culture. If you’re ready to help shape how the world sees brands, we’re ready to grow with you."
banner.image.attach(io: Rails.root.join("public/banners/banner-career.png").open, filename: "banner-career.png")
banner.banner_section = @bs6
Mobility.with_locale(:id) {
	banner.title = "Ciptakan Sesuatu yang Akan Dilihat oleh Dunia"
	banner.description = "Jadilah bagian dari tim yang mengubah ide cemerlang menjadi pengalaman publik yang nyata. Di Prisma Advertising, kami menata ulang apa yang bisa dihasilkan oleh media out-of-home dan media terintegrasi, menciptakan iklan yang bergerak melampaui layar dan melalui jalanan, kota, dan budaya. Jika Anda siap membentuk cara dunia melihat sebuah brand, kami siap tumbuh bersama Anda."
}
banner.save
puts "Create Banner: #{banner.title}"

# banner blog
banner = Banner.new(title: "Publications, Editorials, and Articles Hub on Everything OOH")
banner.description = "Stay informed with insights, trends, and creative perspectives on the evolving world of Out-of-Home advertising, curated by the team behind Prisma Advertising."
banner.image.attach(io: Rails.root.join("public/banners/banner-blog.png").open, filename: "banner-blog.png")
banner.banner_section = @bs7
Mobility.with_locale(:id) {
	banner.title = "Kumpulan Publikasi, Editorial, dan Artikel Seputar OOH"
	banner.description = "Dapatkan informasi terkini seputar berita, tren, dan perspektif kreatif dalam dunia periklanan Out-of-Home yang terus berkembang, disusun langsung oleh tim di balik Prisma Advertising."
}
banner.save
puts "Create Banner: #{banner.title}"

# banner contact
banner = Banner.new(title: "Get in Touch with Prisma Advertising")
banner.description = "We’re ready when you are. Reach out to explore bold OOH media solutions, partnership opportunities, or general inquiries."
banner.image.attach(io: Rails.root.join("public/banners/banner-contact.png").open, filename: "banner-contact.png")
banner.banner_section = @bs8
Mobility.with_locale(:id) {
	banner.title = "Terhubung dengan Prisma Advertising"
	banner.description = "Kami siap kapan pun Anda siap. Silakan hubungi kami untuk menjelajahi solusi media OOH yang menonjol, peluang kerja sama, atau pertanyaan umum lainnya."
}
banner.save
puts "Create Banner: #{banner.title}"
