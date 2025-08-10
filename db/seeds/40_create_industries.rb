Industry.delete_all

# FMCG
@ind1 = Industry.new(name: "FMCG", banner_section: @bs20)
@ind1.caption = "Our Approach to FMCG Advertising"
@ind1.description = %q{
<p>
  We help FMCG brands stand out through strategic, high-impact out-of-home campaigns designed to drive visibility, awareness, and purchase intent. From creative FMCG ads to large-scale product launches, our team delivers.
  industry-specific marketing solutions that are fast, flexible, and results-driven.
</p>
<p>
  Whether you’re looking to build brand loyalty or launch the next big product, our experience in FMCG branding, advertisement of FMCG products, and crafting the best FMCG advertising campaigns ensures your message reaches the right audience at the right time, in the right place.
</p>
}
@ind1.image.attach(io: Rails.root.join("public/industries/fmcg.png").open, filename: "fmcg.png")
Mobility.with_locale(:id) {
  @ind1.name = "FMCG"
  @ind1.caption = "Pendekatan Kami dalam Iklan FMCG"
  @ind1.description = %q{
   <p>Kami membantu brand FMCG menonjol lewat iklan out-of-home yang strategis dan berdampak tinggi untuk meningkatkan visibilitas, kesadaran, dan pembelian. Mulai dari iklan kreatif hingga peluncuran produk skala besar, tim kami menghadirkan solusi pemasaran khusus FMCG yang cepat, fleksibel, dan berorientasi pada hasil.</p>
   <p>Baik dengan tujuan membangun loyalitas brand maupun meluncurkan produk besar berikutnya, pengalaman kami dalam branding dan periklanan FMCG memastikan pesan Anda sampai ke audiens yang tepat, pada waktu dan tempat yang tepat.</p>
  }
}
@ind1.save
puts "Create Industry: #{@ind1.name}"

# E-Commerce
@ind2 = Industry.new(name: "E-Commerce", banner_section: @bs21)
@ind2.caption = "Our Approach to E-Commerce Advertising"
@ind2.description = %q{
  <p>
    In today’s fast-paced digital landscape, ecommerce advertising needs to go beyond the screen. Our out-of-home solutions help online brands build real-world visibility, trust, and top-of-mind awareness.
    From driving traffic to online stores to amplifying digital campaigns, we deliver targeted, high-frequency OOH strategies designed to connect with shoppers wherever they are.
  </p>
  <p>
    Whether launching a new platform, promoting flash sales, or building long-term brand equity, our OOH approach brings scale and impact to your e-commerce growth strategy.
  </p>
}
@ind2.image.attach(io: Rails.root.join("public/industries/e-commerce.png").open, filename: "e-commerce.png")
Mobility.with_locale(:id) {
  @ind2.name = "E-Commerce"
  @ind2.caption = "Pendekatan Kami untuk Iklan E-Commerce"
  @ind2.description = %q{
    <p>Di tengah dunia digital yang serba cepat, iklan e-commerce perlu melampaui sekedar layar. Solusi out-of-home kami membantu brand online membangun visibilitas di dunia nyata, membangun kepercayaan, dan meningkatkan pengenalan secara luas.</p>
    <p>Mulai dari mendorong audiens ke toko online hingga memperkuat iklan digital, kami menghadirkan strategi OOH yang terarah dan berfrekuensi tinggi untuk menjangkau konsumen di mana pun mereka berada. Baik untuk peluncuran platform baru, promosi flash sale, atau membangun nilai brand dalam jangka panjang, pendekatan OOH kami memberikan skala dan dampak nyata untuk strategi pertumbuhan e-commerce Anda.</p>
  }
}
@ind2.save
puts "Create Industry: #{@ind2.name}"

# Telecommunications
@ind3 = Industry.new(name: "Telecommunications", banner_section: @bs22)
@ind3.caption = "Our Approach to the Telecommunications Industry"
@ind3.description = %q{
  <p>Telecommunication advertising demands clarity, consistency, and scale. In a category built on connection, standing out in the real world is essential. Strategic telecommunication ads placed across urban centers, transit spaces, and retail zones keep telco brands visible where decisions happen.</p>
  <p>OOH remains a powerful driver for awareness and trust in mobile plans, data services, and bundled offers. With experience in telco ads that speak to both everyday users and enterprise customers, we support brand growth through high-impact media tailored to the demands of the telecom sector.</p>
}
@ind3.image.attach(io: Rails.root.join("public/industries/telecommunication.png").open, filename: "telecommunication.png")
Mobility.with_locale(:id) {
  @ind3.name = "Telekomunikasi"
  @ind3.caption = "Pendekatan Kami untuk Industri Telekomunikasi"
  @ind3.description = %q{
    <p>Iklan telekomunikasi menuntut kejelasan, konsistensi, dan jangkauan. Dalam industri yang dibangun di atas koneksi, tampil menonjol di ruang publik menjadi hal yang penting. Penempatan iklan yang strategis di pusat kota, area transit, dan pusat ritel menjaga visibilitas brand telko di tempat dimana keputusan dibuat.</p>
    <p>Media OOH tetap menjadi penggerak yang kuat untuk membangun awareness dan kepercayaan terhadap paket data, layanan internet, hingga penawaran bundling. Dengan pengalaman dalam iklan telko yang menargetkan pengguna harian maupun pelanggan korporat, kami mendukung pertumbuhan brand melalui media berdampak tinggi yang disesuaikan dengan kebutuhan industri telekomunikasi.</p>
  }
}
@ind3.save
puts "Create Industry: #{@ind3.name}"

# Automotive
@ind4 = Industry.new(name: "Automotive", banner_section: @bs23)
@ind4.caption = "Our Approach to the Automotive Industry"
@ind4.description = %q{
<p>The way people engage with vehicles may have changed, but the power of great visibility hasn’t. In both new product launches or shifting perception, automotive advertising thrives on presence and persuasion.</p>
<p>Our campaigns are tailored to make car advertising feel less like an ad and more like a moment. Think full-scale automotive billboards that spark interest, car ads that live where the roads are, and creative automotive advertising that turns traffic into attention. From luxury to electric to fleet, we don’t just run automotive ads, we put your brand in motion.</p>
}
@ind4.image.attach(io: Rails.root.join("public/industries/automotive.png").open, filename: "automotive.png")
Mobility.with_locale(:id) {
  @ind4.name = "Otomotif"
  @ind4.caption = "Pendekatan Kami untuk Industri Otomotif"
  @ind4.description = %q{
    <p>Cara orang berinteraksi dengan kendaraan mungkin telah berubah, tapi kekuatan dari visibilitas yang kuat tetap tak tergantikan. Baik dalam peluncuran produk baru maupun perubahan persepsi sektor, iklan otomotif tumbuh lewat kehadiran yang nyata dan pesan yang meyakinkan.</p>
    <p>Setiap iklan kami dirancang agar iklan otomotif terasa bukan sekadar promosi, tapi menjadi momen yang berkesan. Mulai dari billboard berskala besar yang memicu rasa ingin tahu, iklan mobil yang hadir di jalur-jalur strategis, hingga konten kreatif yang mengubah lalu lintas menjadi perhatian. Dari kendaraan mewah, mobil listrik, hingga armada bisnis, kami tidak hanya menjalankan iklan otomotif, tapi menggerakkan brand Anda secara nyata.</p>
  }
}
@ind4.save
puts "Create Industry: #{@ind4.name}"

# Technology & Electronics
@ind5 = Industry.new(name: "Technology & Electronics", banner_section: @bs24)
@ind5.caption = "Our Approach to the Technology and Electronics Industry"
@ind5.description = %q{
<p>From smartphone ads to SaaS branding, our out-of-home solutions help tech brands capture attention in the real world. We support both consumer electronics advertising and B2B advertising with targeted, high-impact placements, from billboard electronics to transit and lifestyle formats.</p>
<p>Whether launching ads for electronics, building a B2B branding presence, or guiding your SaaS advertising journey, we create campaigns that simplify complexity and drive results. Our expertise in advertising electronics ensures your brand connects with the right audience, both the everyday consumers or enterprise buyers.</p>
}
@ind5.image.attach(io: Rails.root.join("public/industries/technology.png").open, filename: "technology.png")
Mobility.with_locale(:id) {
  @ind5.name = "Teknologi & Elektronik"
  @ind5.caption = "Pendekatan Kami untuk Industri Teknologi dan Elektronik"
  @ind5.description = %q{
    <p>Mulai dari iklan smartphone hingga branding SaaS, solusi out-of-home kami membantu brand teknologi menarik perhatian di dunia nyata. Kami mendukung iklan elektronik konsumen maupun B2B melalui penempatan yang terarah dan berdampak tinggi, mulai dari billboard elektronik hingga media transit dan gaya hidup.</p>
    <p>Baik saat meluncurkan produk elektronik, membangun branding B2B, maupun saat mengembangkan strategi iklan SaaS, kami menciptakan iklan yang menyederhanakan kompleksitas dan mendorong hasil nyata. Keahlian kami dalam iklan elektronik memastikan brand Anda terhubung dengan audiens yang tepat, baik konsumen sehari-hari maupun pembeli bidang korporat.</p>
  }
}
@ind5.save
puts "Create Industry: #{@ind5.name}"

# Entertainment & Streaming
@ind6 = Industry.new(name: "Entertainment & Streaming", banner_section: @bs25)
@ind6.caption = "Our Approach to the Entertainment and Streaming Industry"
@ind6.description = %q{
<p>The entertainment and streaming industry thrives on anticipation, emotion, and attention. To stand out in an oversaturated content landscape, brands need campaigns that create noise before a title even drops. Whether it’s a major film advertisement, a sharp tv series ad, or awareness for new platforms, out-of-home gives stories a presence in the real world.</p>
<p>We work with studios, networks, and platforms to amplify visibility through impactful streaming ads, web series ads, and advertisement series that meet people where they are, on the move, in the moment, and ready to tune in.</p>
}
@ind6.image.attach(io: Rails.root.join("public/industries/entertainment.png").open, filename: "entertainment.png")
Mobility.with_locale(:id) {
  @ind6.name = "Hiburan & Streaming"
  @ind6.caption = "Pendekatan Kami untuk Industri Hiburan dan Streaming"
  @ind6.description = %q{
    <p>Industri hiburan dan streaming bertumpu pada antisipasi, emosi, dan perhatian. Di tengah dunia konten yang begitu padat, brand perlu menghadirkan iklan yang sudah mencuri perhatian bahkan sebelum iklan dirilis. Baik itu promosi film besar, serial TV terbaru, atau platform streaming baru, media out-of-home (OOH) memberi ruang bagi cerita Anda untuk hadir secara nyata di dunia luar.</p>
    <p>Kami bekerja sama dengan studio, jaringan televisi, dan platform digital untuk meningkatkan visibilitas melalui iklan streaming, promosi web series, dan iklan yang menjangkau audiens di mana pun mereka berada, baik saat bergerak, saat di momen yang tepat, maupun saat siap untuk menonton.</p>
  }
}
@ind6.save
puts "Create Industry: #{@ind6.name}"

# Transportation & Superapp
@ind7 = Industry.new(name: "Transportation & Superapp", banner_section: @bs26)
@ind7.caption = "Our Approach to the Transportation and SuperApp Industry"
@ind7.description = %q{
<p>Whether you’re moving people, delivering goods, or expanding your ecosystem into payments, food, and lifestyle, your brand has to travel with your audience. High-impact transportation ads help superapps and transit services stay top of mind in a fast-moving market.</p>
<p>We support scalable campaigns across fleets, terminals, and public spaces, blending transport branding with digital-first strategy. Our work in transportation advertisement drives awareness, downloads, and usage across ride-hailing, logistics, and lifestyle platforms. Every transport ad we place is powered by BoostAD, built for reach, adaptability, and performance across the urban grid.</p>
}
@ind7.image.attach(io: Rails.root.join("public/industries/transportation.png").open, filename: "transportation.png")
Mobility.with_locale(:id) {
  @ind7.name = "Transportasi dan SuperApp"
  @ind7.caption = "Pendekatan Kami untuk Industri Transportasi dan SuperApp"
  @ind7.description = %q{
    <p>Baik ketika Anda menggerakkan orang, mengantar barang, atau memperluas ekosistem ke pembayaran, makanan, dan gaya hidup, brand Anda harus hadir di mana audiens berada. Iklan transportasi berdampak tinggi membantu superapp dan layanan transit tetap diingat di kawasan yang bergerak cepat.</p>
    <p>Kami mendukung iklan berskala luas di berbagai terminal dan ruang publik dengan memadukan branding transportasi dan strategi digital. Pengalaman kami dalam iklan transportasi mendorong pengenalan, tingkat unduhan, dan penggunaan di platform ride-hailing, logistik, dan gaya hidup. Setiap iklan transportasi yang kami hadirkan didukung oleh BoostAD, dirancang untuk jangkauan, fleksibilitas, dan kinerja maksimal di seluruh jaringan kota.</p>
  }
}
@ind7.save
puts "Create Industry: #{@ind7.name}"

# Financial Services & Fintech
@ind8 = Industry.new(name: "Financial Services & Fintech", banner_section: @bs27)
@ind8.caption = "Our Approach to Financial Services and Fintech Industry"
@ind8.description = %q{
  <p>Trust and clarity are everything in finance. Whether you’re building a challenger bank, promoting payment platforms, or launching new investment tools, visibility drives adoption. Strong finance branding and well-placed financial services advertising help cut through skepticism and noise.</p>
  <p>From app-based platforms to full-scale banking solutions, our campaigns are shaped by fintech advertising strategies that connect with modern consumers on the move. OOH remains one of the most effective channels for driving brand recall, trust, and action in financial advertising</p>
}
@ind8.image.attach(io: Rails.root.join("public/industries/financial.png").open, filename: "financial.png")
Mobility.with_locale(:id) {
  @ind8.name = "Jasa Keuangan dan Fintech"
  @ind8.caption = "Pendekatan Kami untuk Industri Jasa Keuangan dan Fintech"
  @ind8.description = %q{
    <p>Kepercayaan dan kejelasan adalah segalanya dalam dunia finansial. Baik Anda sedang membangun bank digital, mempromosikan platform pembayaran, maupun meluncurkan alat investasi baru, visibilitas adalah kunci utama. Branding keuangan yang kuat dan penempatan iklan yang tepat membantu menembus keraguan dan kebisingan informasi.</p>
    <p>Dari aplikasi keuangan hingga solusi perbankan skala besar, setiap iklan kami dibentuk dengan strategi iklan fintech yang relevan dengan konsumen modern yang dinamis. Media OOH tetap menjadi salah satu saluran paling efektif untuk mendorong ingatan akan brand, kepercayaan, dan aksi nyata dalam periklanan jasa keuangan.</p>
  }
}
@ind8.save
puts "Create Industry: #{@ind8.name}"
