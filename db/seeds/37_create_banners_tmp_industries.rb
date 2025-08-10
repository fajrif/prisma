# FMCG
banner = Banner.new(title: "Creative FMCG Ads That Drive Real-World Impact")
banner.description = "Position your product at the center of attention with OOH tailored for fast-moving consumer goods."
banner.image.attach(io: Rails.root.join("public/banners/industries/fmcg.png").open, filename: "fmcg.png")
banner.banner_section = @bs20
Mobility.with_locale(:id) {
	banner.title = "Iklan FMCG Kreatif dengan Dampak Nyata"
	banner.description = "Posisikan produk Anda sebagai pusat perhatian dengan iklan OOH spesifik khusus untuk industri FMCG (fast-moving consumer goods)."
}
banner.save
puts "Create Banner: #{banner.title}"

# E-Commerce
banner = Banner.new(title: "Bringing E-Commerce Brands Into the Real World")
banner.description = "Bridge the gap with targeted OOH campaigns built for modern e-commerce growth."
banner.image.attach(io: Rails.root.join("public/banners/industries/e-commerce.png").open, filename: "e-commerce.png")
banner.banner_section = @bs21
Mobility.with_locale(:id) {
	banner.title = "Membawa Brand E-Commerce di Dunia Nyata"
	banner.description = "Jembatani celah dengan iklan OOH terarah yang dirancang untuk pertumbuhan e-commerce masa kini."
}
banner.save
puts "Create Banner: #{banner.title}"

# Telecommunications
banner = Banner.new(title: "Build Brand Visibility in a Fast-Moving, Hyper-Connected Telco Market")
banner.description = "OOH delivers lasting impact for telecommunications brands competing on speed, coverage, and trust."
banner.image.attach(io: Rails.root.join("public/banners/industries/telecommunication.png").open, filename: "telecommunication.png")
banner.banner_section = @bs22
Mobility.with_locale(:id) {
	banner.title = "Bangun Visibilitas Brand di Sektor Telekomunikasi yang Dinamis dan Terhubung dengan Cepat"
	banner.description = "Media OOH memberikan dampak yang besar dan tahan lama bagi brand telekomunikasi yang bersaing dalam hal kecepatan, jangkauan, dan kepercayaan."
}
banner.save
puts "Create Banner: #{banner.title}"

# Automotive
banner = Banner.new(title: "Elevate Your Automotive Brand Through Intelligent Outdoor Media")
banner.description = "Reach drivers, enthusiasts, and new buyers with automotive advertising."
banner.image.attach(io: Rails.root.join("public/banners/industries/automotive.png").open, filename: "automotive.png")
banner.banner_section = @bs23
Mobility.with_locale(:id) {
	banner.title = "Tingkatkan Brand Otomotif Anda Lewat Media Luar Ruang yang Cerdas"
	banner.description = "Jangkau para pengemudi, pecinta otomotif, dan calon pembeli baru dengan iklan luar ruang yang tepat sasaran."
}
banner.save
puts "Create Banner: #{banner.title}"

# Technology & Electronics
banner = Banner.new(title: "OOH That Moves Tech Forward")
banner.description = "Helping tech and electronic brands connect with real-world audiences through industry-specific advertising."
banner.image.attach(io: Rails.root.join("public/banners/industries/technology.png").open, filename: "technology.png")
banner.banner_section = @bs24
Mobility.with_locale(:id) {
	banner.title = "OOH yang Mendorong Inovasi Teknologi"
	banner.description = "Membantu brand teknologi dan elektronik terhubung dengan audiens yang nyata melalui strategi iklan yang relevan dengan industri."
}
banner.save
puts "Create Banner: #{banner.title}"

# Entertainment & Streaming
banner = Banner.new(title: "Set the Stage for What’s Streaming Next")
banner.description = "Drive anticipation and viewership by turning screens, streets, and cities into show-stopping OOH moments."
banner.image.attach(io: Rails.root.join("public/banners/industries/entertainment.png").open, filename: "entertainment.png")
banner.banner_section = @bs25
Mobility.with_locale(:id) {
	banner.title = "Siapkan Panggung untuk Tayangan Berikutnya"
	banner.description = "Bangun antisipasi dan tingkatkan jumlah penonton dengan mengubah layar, jalanan, dan kota menjadi momen OOH yang mencuri perhatian."
}
banner.save
puts "Create Banner: #{banner.title}"

# Transportation & Superapp
banner = Banner.new(title: "Smart Transport Advertising at City Scale")
banner.description = "Combine bold transportation ads with strategic placement with power from BoostAD."
banner.image.attach(io: Rails.root.join("public/banners/industries/transportation.png").open, filename: "transportation.png")
banner.banner_section = @bs26
Mobility.with_locale(:id) {
	banner.title = "Iklan Transportasi Cerdas dalam Skala Kota"
	banner.description = "Gabungkan iklan transportasi yang mencuri perhatian dengan penempatan strategis yang didukung oleh BoostAD."
}
banner.save
puts "Create Banner: #{banner.title}"

# Financial Services & Fintech
banner = Banner.new(title: "Build Trust Through Smarter Financial Advertising")
banner.description = "Let your financial services speak louder through out-of-home campaigns."
banner.image.attach(io: Rails.root.join("public/banners/industries/fintech.png").open, filename: "fintech.png")
banner.banner_section = @bs27
Mobility.with_locale(:id) {
	banner.title = "Bangun Kepercayaan Lewat Iklan Finansial yang Lebih Cerdas"
	banner.description = "Biarkan layanan keuangan Anda berbicara lebih kuat melalui iklan out-of-home yang strategis dan berdampak."
}
banner.save
puts "Create Banner: #{banner.title}"
