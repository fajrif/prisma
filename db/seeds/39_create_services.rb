Service.delete_all

# Static Billboard Advertising
@srv1 = Service.new(name: "Static Billboard Advertising", banner_section: @bs10, color: "#DC5EBD")
@srv1.caption = "Command Attention with High-Impact Static Billboard Advertising"
@srv1.description = "From Jakarta to West Java, our static billboards provide long-lasting brand visibility in premium locations. A proven OOH advertising format, ideal for consistent outdoor exposure and top-of-mind recall."
@srv1.short_description = "Maximize brand exposure with high-impact static billboards in prime locations. A powerful solution for consistent, long-term visibility."
@srv1.benefit_title = "Benefits of Static Billboards"
@srv1.benefit_description = "Static billboards offer a strong combination of reach, repetition, and permanence. Here’s what makes them effective:"
@srv1.image.attach(io: Rails.root.join("public/services/static-billboard.png").open, filename: "static-billboard.png")
@srv1.image1.attach(io: Rails.root.join("public/services/image1.png").open, filename: "image1.png")
Mobility.with_locale(:id) {
  @srv1.name = "Papan Reklame Statis"
  @srv1.caption = "Tingkatkan Eksposur Brand dengan Billboard Statis Berimpact Tinggi"
  @srv1.description = "Papan billboard statis kami hadir di lokasi strategis di Jakarta dan seluruh Indonesia, menciptakan kehadiran visual yang konsisten dan berdampak untuk memperkuat brand Anda."
  @srv1.short_description = "Maksimalkan jangkauan brand Anda dengan papan reklame statis di berbagai lokasi pusat. Solusi terbaik untuk visibilitas yang konsisten dan jangka panjang."
  @srv1.benefit_title = "Manfaat dari Billboard Statis"
  @srv1.benefit_description = "Berikut adalah alasan mengapa billboard statis masih menjadi salah satu jenis-jenis reklame paling efektif:"
}
@srv1.save
puts "Create Service: #{@srv1.name}"

# Digital Billboard Advertising
@srv2 = Service.new(name: "Digital Billboard Advertising", banner_section: @bs11, color: "#3473EE")
@srv2.caption = "Shine Brighter with Digital Billboard Advertising (DOOH)"
@srv2.description = "Our vibrant LED billboards deliver real-time, dynamic visuals across Indonesia. With powerful DOOH advertising, your brand stays visible day and night in key urban spaces."
@srv2.short_description = "Deliver dynamic, real-time messaging with striking digital displays. Ideal for campaigns that demand flexibility and immediacy."
@srv2.benefit_title = "Benefits of Digital Billboards"
@srv2.benefit_description = "Digital billboards offer the agility and innovation today’s brands need to stay relevant and bold in a fast-moving world. Here’s why advertisers choose this format:"
@srv2.image.attach(io: Rails.root.join("public/services/digital-billboard.png").open, filename: "digital-billboard.png")
@srv1.image1.attach(io: Rails.root.join("public/services/image3.png").open, filename: "image3.png")
Mobility.with_locale(:id) {
  @srv2.name = "Papan Reklame Digital"
  @srv2.caption = "Tampil Lebih Terang dengan Billboard Digital (DOOH)"
  @srv2.description = "Billboard digital kami menampilkan visual dinamis dan real-time lewat papan LED di lokasi strategis. Solusi DOOH advertising yang menjaga brand Anda tetap terlihat siang dan malam di seluruh Indonesia."
  @srv2.short_description = "Menyalurkan pesan secara langsung melalui tampilan digital yang dinamis. Cocok untuk iklan dengan fleksibilitas tinggi."
  @srv2.benefit_title = "Manfaat dari Billboard Digital"
  @srv2.benefit_description = "Billboard digital memberikan fleksibilitas dan inovasi yang dibutuhkan brand masa kini untuk tetap relevan dan berani di tengah dunia yang terus bergerak cepat. Berikut alasan mengapa banyak pengiklan memilih format ini:"
}
@srv2.save
puts "Create Service: #{@srv2.name}"

# Creative OOH Branding
@srv3 = Service.new(name: "Creative OOH Branding", banner_section: @bs12, color: "#6759E1")
@srv3.caption = "Make Your Brand Unforgettable with Creative OOH Advertising"
@srv3.description = "We specialize in OOH advertising that transforms everyday spaces into impactful brand moments, with help from BoostAD. From concept to execution, we turn traditional OOH media into immersive experiences that capture attention and make a lasting impression."
@srv3.short_description = "Stand out with custom-built, attention-grabbing OOH executions supported by BoostAD. Designed to elevate brand perception and audience engagement."
@srv3.benefit_title = "Benefits of Creative OOH Branding"
@srv3.benefit_description = "Creative OOH advertising transforms static billboards into sculptural brand statements. Here’s why advertisers choose this format:"
@srv3.image.attach(io: Rails.root.join("public/services/creative-ooh.png").open, filename: "creative-ooh.png")
@srv1.image1.attach(io: Rails.root.join("public/services/image6.png").open, filename: "image6.png")
Mobility.with_locale(:id) {
  @srv3.name = "Branding OOH Kreatif"
  @srv3.caption = "Buat Brand Anda Tak Terlupakan dengan Iklan OOH Kreatif"
  @srv3.description = "Kami menghadirkan iklan OOH yang mengubah ruang sehari-hari menjadi momen berkesan. Dari konsep hingga eksekusi, kami menciptakan media luar ruang yang menarik perhatian dan memberikan pengalaman yang tak terlupakan."
  @srv3.short_description = "Tampil menonjol dan mengesankan dengan iklan OOH yang didukung oleh BoostAD, dirancang khusus untuk brand Anda, mampu untuk meningkatkan citra brand serta interaksi dengan audiens."
  @srv3.benefit_title = "Manfaat dari Branding OOH Kreatif"
  @srv3.benefit_description = "Branding OOH kreatif memberikan dampak tinggi dengan menjangkau audiens dalam konteks kehidupan sehari-hari. Inilah keunggulannya:"
}
@srv3.save
puts "Create Service: #{@srv3.name}"

# Transit Media
@srv4 = Service.new(name: "Transit Advertising", banner_section: @bs13, color: "#6EB7B8")
@srv4.caption = "Put Your Brand on the Move with Transit Advertising Powered by BoostAD"
@srv4.description = "Your message travels through the city with high-visibility bus advertisements and transit media branding. Expand your campaign with smart, targeted impressions via public transportation."
@srv4.short_description = "Capture attention on the move with strategic placements across public transportation with the help of BoostAD. Extend your reach across urban and commuter routes."
@srv4.benefit_title = "Benefits of Transit Advertising powered by BoostAD"
@srv4.benefit_description = "Benefits of Transit Advertising Powered by BoostAD Transit media delivers your message with:"
@srv4.image.attach(io: Rails.root.join("public/services/boostad-logo.png").open, filename: "boostad-logo.png")
@srv1.image1.attach(io: Rails.root.join("public/services/image2.png").open, filename: "image2.png")
Mobility.with_locale(:id) {
  @srv4.name = "Media Transit"
  @srv4.caption = "Gerakkan Brand Anda Lewat Iklan Transportasi"
  @srv4.description = "Iklan di bus, seperti iklan bus TransJakarta, menjadikan perjalanan harian sebagai media branding yang efektif. Iklan transportasi umum adalah cara cerdas untuk menjangkau audiens yang terus bergerak."
  @srv4.short_description = "Dapatkan perhatian dari penempatan iklan yang strategis di transportasi umum. Didukung oleh BoostAD, perluas jangkauan iklan Anda di jalur transportasi kota."
  @srv4.benefit_title = "Manfaat dari Iklan Transit Bersama BoostAD"
  @srv4.benefit_description = "Mengapa brand memilih iklan transportasi umum?"
}
@srv4.save
puts "Create Service: #{@srv4.name}"

# OOH Media Dashboard Access
@srv5 = Service.new(name: "OOH Dashboard", banner_section: @bs14, color: "#CD68B9")
@srv5.caption = "Smarter Planning with Our OOH Media Dashboard"
@srv5.description = "Our media dashboard helps you plan and optimize out-of-home advertising with precision. Backed by reach data and location insights, it recommends the best OOH billboard placements across Jakarta and Indonesia, tailored to your goals."
@srv5.short_description = "Gain full control and visibility over your campaigns with our intuitive dashboard. Track performance, manage assets, and optimize results in real time."
@srv5.benefit_title = "Benefits of OOH Dashboard"
@srv5.benefit_description = "Gain full control and visibility over your out-of-home advertising strategy with our integrated campaign tools:"
@srv5.image.attach(io: Rails.root.join("public/services/ooh-media-dashboard.png").open, filename: "ooh-media-dashboard.png")
@srv1.image1.attach(io: Rails.root.join("public/services/image5.png").open, filename: "image5.png")
Mobility.with_locale(:id) {
  @srv5.name = "Dashboard OOH"
  @srv5.caption = "Rencanakan Iklan Lebih Cerdas dengan Dashboard OOH Kami"
  @srv5.description = "Dashboard iklan kami membantu merancang dan mengukur media luar ruang secara akurat. Dengan data jangkauan dan insight lokasi, kami merekomendasikan iklan OOH terbaik di Jakarta dan seluruh Indonesia, sesuai target Anda."
  @srv5.short_description = "Kendalikan dan pantau iklan Anda sepenuhnya dengan dashboard yang praktis. Lacak performa, kelola aset, dan optimalkan hasil secara langsung."
  @srv5.benefit_title = "Manfaat dari Dashboard Iklan OOH"
  @srv5.benefit_description = "Kelola strategi media luar ruang Anda dengan lebih efisien melalui sistem terintegrasi:"
}
@srv5.save
puts "Create Service: #{@srv5.name}"

# PiX Creative Mindworks
@srv6 = Service.new(name: "PiX Creative Mindworks", banner_section: @bs15, color: "#000")
@srv6.caption = "Bold Digital Animation for Next-Level OOH Impact"
@srv6.description = "Formerly known as PiX Animation, PiX Creative Mindworks pushes creative boundaries with high-impact CGI, 3D, and 4D animation content for digital billboard campaigns and interactive LED displays. As a leading animation studio, we create stunning digital animation and motion graphics that light up screens and captivate audiences in the OOH space."
@srv6.short_description = "Bring your vision to life with our in-house animation and motion design studio. Tailored creative solutions that enhance your OOH impact."
@srv6.image.attach(io: Rails.root.join("public/services/pix-creative-mindworks.png").open, filename: "pix-creative-mindworks.png")
@srv1.image1.attach(io: Rails.root.join("public/services/image4.png").open, filename: "image4.png")
Mobility.with_locale(:id) {
  @srv6.name = "PiX Creative Mindworks"
  @srv6.caption = "Animasi Digital yang Mendorong Batas Kreativitas OOH"
  @srv6.description = "Sebelumnya dikenal sebagai PiX Animation, kini PiX Creative Mindworks menghadirkan animasi 3D, CGI animation, dan visual 4D berkualitas tinggi untuk digital billboard dan kampanye digital out-of-home advertising. PiX siap menjadikan ide Anda tampil menonjol di ruang publik."
  @srv6.short_description = "Bawa visi kreatif Anda menjadi hidup dengan animasi dari studio motion design milik kami. Solusi inovatif  yang dirancang khusus untuk memaksimalkan dampak iklan OOH Anda."
}
@srv6.save
puts "Create Service: #{@srv6.name}"
