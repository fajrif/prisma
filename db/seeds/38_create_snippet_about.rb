## create our_story
our_story = Snippet.new(name: "our_story")
our_story.title = "Our Story"
our_story.short_description = "<p>Prisma Advertising, under the legal entity PT Prisma Harapan, is a leading out-of-home (OOH) advertising company in Indonesia. Since 1992, we’ve helped brands build meaningful connections with their audiences through strategic placements, bold creative, and data-driven insights.</p><p>With over three decades of experience, we operate across Jakarta, Bali, and Bandung, delivering impactful campaigns through billboards, transit media, LED screens, and DOOH formats. Our solutions are designed to meet the needs of brands in high-traffic urban spaces—where attention is earned, not assumed.</p>"
our_story.description = "From billboards in Jakarta to vibrant displays in Bali and West Java, we deliver smart, scalable advertising that makes brands stand out in the real world. Our strength lies in combining premium service, innovative formats, and storytelling that leaves a lasting impression."
our_story.image.attach(io: Rails.root.join("public/images/our-story.png").open, filename: "our-story.png")
Mobility.with_locale(:id) {
  our_story.title = "Cerita Dibalik Prisma"
  our_story.short_description = "<p>Prisma Advertising, di bawah entitas hukum PT Prisma Harapan, adalah perusahaan periklanan luar ruang (OOH) terdepan di Indonesia. Sejak tahun 1992, kami telah membantu brand membangun koneksi yang bermakna melalui penempatan strategis, kreativitas visual, dan data yang terpercaya.</p><p>Dengan pengalaman lebih dari tiga dekade, kami melayani wilayah Jakarta, Bali, dan Bandung (Jawa Barat)—menyediakan solusi iklan melalui billboard, media transportasi, layar LED, dan format DOOH yang menjangkau jutaan orang setiap hari.</p>"
  our_story.description = "Dari billboard di Jakarta hingga kampanye DOOH yang dinamis di Bali dan Bandung, kami menghadirkan solusi iklan yang cerdas, scalable, dan berdampak nyata. Kekuatan kami ada pada layanan premium, inovasi format, dan storytelling yang membekas di benak audiens."
}
our_story.save

Section.create(page_id: @about_page.id, snippet_id: our_story.id, order_no: 1)
puts "create Snippet: #{our_story.name}"

## create philosophy
philosophy = Snippet.new(name: "philosophy")
philosophy.template = "info_bg"
philosophy.title = "Philosophy"
philosophy.short_description = "We did inspired by prism, a medium to disperse white light or sunlight into 7 natural spectrum colours."
philosophy.description = "There by prism has become our logo and foundation to run our vision and mission. Prisma aim to become a media full of colours, where a wish transformed into a happiness, reflected in beauty, and the intended purposes could be delivered. We aim to be a media where people can share stories and be united in togetherness."
philosophy.background.attach(io: Rails.root.join("public/background/bg-info-3.png").open, filename: "bg-info-3.png")
Mobility.with_locale(:id) {
  philosophy.title = "Filosofi Prisma"
  philosophy.short_description = "Kami terinspirasi dari prisma, sebuah medium yang mampu membiaskan cahaya putih atau sinar matahari menjadi tujuh spektrum warna alami."
  philosophy.description = "Oleh karena itu, prisma menjadi logo sekaligus dasar dalam menjalankan visi dan misi kami. Prisma bertujuan menjadi media yang penuh warna, tempat harapan diubah menjadi kebahagiaan, tercermin dalam keindahan, dan maksud yang ingin disampaikan dapat diterima dengan baik. Kami ingin menjadi media tempat orang dapat berbagi cerita dan bersatu dalam kebersamaan."
}
philosophy.save

Section.create(page_id: @about_page.id, snippet_id: philosophy.id, order_no: 2)
puts "create Snippet: #{philosophy.name}"

## create vision_mission
vision_mission = Snippet.new(name: "vision_mission")
vision_mission.title = "Vision & Mission"
vision_mission.short_description = "Reflecting more than goals, our mission and vision represent our commitment to creating meaningful impact."
Mobility.with_locale(:id) {
  vision_mission.title = "Visi dan Misi"
  vision_mission.short_description = "Lebih dari sekedar tujuan, visi dan misi kami menunjukkan komitmen yang kuat dalam menciptakan dampak yang besar."
}
vision_mission.save

Section.create(page_id: @about_page.id, snippet_id: vision_mission.id, order_no: 3)
puts "create Snippet: #{vision_mission.name}"

## create our_values
our_values = Snippet.new(name: "our_values")
our_values.title = "Our Values"
our_values.short_description = "The foundation of everything we do. Built on trust, creativity, accountability, and a relentless drive to deliver excellence in every campaign."
our_values.image.attach(io: Rails.root.join("public/images/prisma-green.png").open, filename: "prisma-green.png")
our_values.background.attach(io: Rails.root.join("public/background/bg-prisma-values.png").open, filename: "bg-prisma-values.png")
Mobility.with_locale(:id) {
  our_values.title = "Prinsip Dasar Kami"
  our_values.short_description = "Dasar nilai dari apa yang kami kerjakan. Dibangun atas kepercayaan, kreativitas, tanggung jawab, dan semangat tanpa henti untuk menghadirkan kualitas terbaik di setiap iklan."
}
our_values.save

Section.create(page_id: @about_page.id, snippet_id: our_values.id, order_no: 4)
puts "create Snippet: #{our_values.name}"

## create our_services
our_services = Snippet.new(name: "our_services")
our_services.title = "What We Do"
our_services.short_description = "We craft out-of-home campaigns that captivate, connect, and deliver measurable results."
Mobility.with_locale(:id) {
  our_services.title = "Layanan Utama"
  our_services.short_description = "Kami merancang iklan luar ruang (out-of-home) yang menarik perhatian, menghubungkan audiens, dan memberikan hasil yang terukur."
}
our_services.save

Section.create(page_id: @about_page.id, snippet_id: our_services.id, order_no: 5)
puts "create Snippet: #{our_services.name}"

## create our_impact
our_impact = Snippet.new(name: "our_impact")
our_impact.title = "Our Impact"
our_impact.short_description = "Take a look at how we’ve helped brands turn visibility into real-world impact."
Mobility.with_locale(:id) {
  our_impact.title = "Dampak Kami"
  our_impact.short_description = "Lihat bagaimana kami membantu brand mengubah visibilitas menjadi dampak yang nyata."
}
our_impact.save

Section.create(page_id: @about_page.id, snippet_id: our_impact.id, order_no: 6)
puts "create Snippet: #{our_impact.name}"


## create our_portfolios
our_portfolios = Snippet.new(name: "our_portfolios")
our_portfolios.title = "Campaign Highlights"
our_portfolios.short_description = "Real projects, real results. See our work in action."
Mobility.with_locale(:id) {
  our_portfolios.title = "Kumpulan Iklan dari Kami"
  our_portfolios.short_description = "Proyek nyata dengan hasil nyata. Lihat lebih lanjut hasil karya kami."
}
our_portfolios.save

Section.create(page_id: @about_page.id, snippet_id: our_portfolios.id, order_no: 7)
puts "create Snippet: #{our_portfolios.name}"

## create out_of_home
out_of_home = Snippet.new(name: "out_of_home")
out_of_home.template = "info_text_box"
out_of_home.title = "Why Out-of-Home Still Works"
out_of_home.short_description = "<p>In a world flooded with digital noise, out-of-home (OOH) advertising continues to cut through—offering brands real, physical presence in the places that matter. Whether it's billboards in Jakarta, transit ads, or DOOH screens in urban hotspots, OOH reaches people where they live, move, and make decisions.</p><p>Unlike ads that can be skipped or blocked, OOH is always on, highly visible, and seamlessly integrated into daily life. It builds awareness, strengthens brand recall, and drives real-world action—especially when combined with digital campaigns.</p><p>As urban mobility grows and attention becomes harder to capture, OOH remains one of the most powerful, credible, and scalable media channels for modern brands.</p>"
out_of_home.background.attach(io: Rails.root.join("public/background/bg-prisma-ooh.png").open, filename: "bg-prisma-ooh.png")
Mobility.with_locale(:id) {
  out_of_home.title = "Mengapa Out-of-Home Tetap Efektif"
  out_of_home.short_description = "<p>Di tengah dunia digital yang penuh distraksi, iklan luar ruang (OOH) tetap mampu mencuri perhatian. Mulai dari billboard di Jakarta, iklan transportasi di Bandung, hingga layar DOOH di Bali, OOH hadir di ruang publik tempat orang bergerak, beraktivitas, dan membuat keputusan.</p><p>Berbeda dengan iklan digital yang bisa dilewati, OOH selalu terlihat, alami dalam keseharian, dan tidak bisa diblokir. Ia membangun kesadaran brand, memperkuat ingatan, dan mendorong tindakan nyata, terutama saat dikombinasikan dengan kampanye digital.</p><p>Dengan mobilitas kota yang makin tinggi dan perhatian yang makin terbagi, OOH tetap menjadi kanal media yang kuat, kredibel, dan scalable bagi brand masa kini.</p>"
}
out_of_home.save

Section.create(page_id: @about_page.id, snippet_id: out_of_home.id, order_no: 8)
puts "create Snippet: #{out_of_home.name}"

## create our_clients
our_clients = Snippet.new(name: "our_clients")
our_clients.title = "Trusted by Leading Brands"
our_clients.short_description = "Explore the list of clients who have chosen our service."
Mobility.with_locale(:id) {
  our_clients.title = "Dipercayai oleh Brand Terkemuka"
  our_clients.short_description = "Jelajahi berbagai klien ternama yang telah memilih jasa kami."
}
our_clients.save

Section.create(page_id: @about_page.id, snippet_id: our_clients.id, css_class: "pt-0 pb-0", order_no: 9)
puts "create Snippet: #{our_clients.name}"

## create testimonials
testimonials = Snippet.new(name: "testimonials")
testimonials.title = "Testimonials"
testimonials.short_description = "See how our previous clients appraised their experience with us."
Mobility.with_locale(:id) {
  testimonials.title = "Testimoni"
  testimonials.short_description = "Dapatkan kesan dari brand yang sudah mempercayai kami."
}
testimonials.save

Section.create(page_id: @about_page.id, snippet_id: testimonials.id, bg_color: "bg-grey", order_no: 10)
puts "create Snippet: #{testimonials.name}"

## create our_industries
our_industries = Snippet.new(name: "our_industries")
our_industries.title = "Industries We Serve"
our_industries.short_description = "We’ve helped brands from diverse sectors—consumer goods, technology, e-commerce, finance, education, and government initiatives. Every campaign is crafted to meet each industry’s goals, whether that means product awareness, location-based engagement, or full-funnel visibility."
our_industries.image.attach(io: Rails.root.join("public/images/prism.png").open, filename: "prism.png")
our_industries.background.attach(io: Rails.root.join("public/background/bg-industry.png").open, filename: "bg-industry.png")
Mobility.with_locale(:id) {
  our_industries.title = "Industri yang Kami Layani"
  our_industries.short_description = "Kami telah membantu klien dari berbagai sektor—teknologi, FMCG, keuangan, e-commerce, pendidikan, dan pemerintahan. Setiap kampanye kami rancang berdasarkan kebutuhan industri, mulai dari awareness hingga aksi nyata di lapangan."
}
our_industries.save

Section.create(page_id: @about_page.id, snippet_id: our_industries.id, bg_color: "bg-image", css_class: "half-section", order_no: 11)
puts "create Snippet: #{our_industries.name}"
