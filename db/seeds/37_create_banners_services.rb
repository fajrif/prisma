# Static Billboard Advertising
banner = Banner.new(title: "Out-of-Home (OOH) Billboard Advertising with Lasting Impact")
banner.description = "The original attention grabber. Keeping your brand front and center across Jakarta, Indonesia, and beyond."
banner.image.attach(io: Rails.root.join("public/banners/services/static-billboard.png").open, filename: "static-billboard.png")
banner.banner_section = @bs10
Mobility.with_locale(:id) {
	banner.title = "Papan Reklame Luar Ruang (OOH) dengan Dampak yang Tak Terlupakan"
	banner.description = "Solusi klasik yang tetap efektif, membuat brand Anda tetap menjadi sorotan di Jakarta, Indonesia, dan sekitarnya."
}
banner.save
puts "Create Banner: #{banner.title}"

# Digital Billboard Advertising
banner = Banner.new(title: "Billboard Advertising Goes Digital with Striking LED Displays Across Indonesia")
banner.description = "Tell your brand story with high-impact digital billboards designed to command attention, day and night."
banner.image.attach(io: Rails.root.join("public/banners/services/digital-billboard.png").open, filename: "digital-billboard.png")
banner.banner_section = @bs11
Mobility.with_locale(:id) {
	banner.title = "Jadikan Iklan Anda Pusat Perhatian dengan Billboard Digital"
	banner.description = "Ungkapkan cerita brand Anda melalui visual bergerak yang mencuri perhatian, hanya dengan papan reklame digital dari Prisma Advertising."
}
banner.save
puts "Create Banner: #{banner.title}"

# Creative OOH Branding
banner = Banner.new(title: "Expanding Reach in Everyday Places")
banner.description = "Our creative branding and promotional network stretches into malls, offices, and lifestyle zones. Expanding your OOH Jakarta presence where your audience lives, works, and plays."
banner.image.attach(io: Rails.root.join("public/banners/services/creative-ooh-branding.png").open, filename: "creative-ooh-branding.png")
banner.banner_section = @bs12
Mobility.with_locale(:id) {
	banner.title = "Menjangkau Lebih Luas di Berbagai Lokasi"
	banner.description = "Cakupan branding dan promosi kami menjangkau pusat perbelanjaan, area perkantoran, hingga berbagai ruang publik strategis di Indonesia."
}
banner.save
puts "Create Banner: #{banner.title}"

# Transit Advertising
banner = Banner.new(title: "Your Campaign, Always on the Move")
banner.description = "Turn everyday commutes into powerful brand moments with bus branding, transport media, and more."
banner.image.attach(io: Rails.root.join("public/banners/services/transit-adv.png").open, filename: "transit-adv.png")
banner.banner_section = @bs13
Mobility.with_locale(:id) {
	banner.title = "Kampanye Anda, Selalu Bergerak dan Terlihat"
	banner.description = "Ubah transportasi sehari-hari menjadi peluang iklan yang berdampak dengan iklan di bus dan sebagainya."
}
banner.save
puts "Create Banner: #{banner.title}"

# OOH Media Dashboard Access
banner = Banner.new(title: "Take Control of Your Out-of-Home Advertising in Real Time")
banner.description = "Track performance, monitor placements, and optimize your OOH media strategy with our powerful, easy-to-use media dashboard."
banner.image.attach(io: Rails.root.join("public/banners/services/ooh-media-dashboard.png").open, filename: "ooh-media-dashboard.png")
banner.banner_section = @bs14
Mobility.with_locale(:id) {
	banner.title = "Ambil Kendali Penuh atas Iklan Luar Ruang Anda"
	banner.description = "Pantau performa, kelola penempatan, dan optimalkan strategi media OOH Anda dalam satu dashboard yang intuitif dan mudah digunakan."
}
banner.save
puts "Create Banner: #{banner.title}"

# PiX Creative Mindworks
banner = Banner.new(title: "PiX Creative Mindworks: Bold Visuals for Bold Brands")
banner.description = "Bring your campaigns to life with eye-catching motion graphics and 3D animation designed for out-of-home (OOH) impact."
banner.image.attach(io: Rails.root.join("public/banners/services/pix-creative.png").open, filename: "pix-creative.png")
banner.banner_section = @bs15
Mobility.with_locale(:id) {
	banner.title = "PiX Creative Mindworks: Visual Berani untuk Brand Berani"
	banner.description = "Hidupkan kampanye Anda dengan motion graphics dan animasi 3D yang mencuri perhatian, dirancang khusus untuk dampak media luar ruang (OOH)."
}
banner.save
puts "Create Banner: #{banner.title}"
