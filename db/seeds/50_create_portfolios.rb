# Create Portfolios
Portfolio.delete_all
puts "Create Portfolios data"

service = Service.first
industry = Industry.first
names = ["BYD Indonesia", "Pocari Sweat", "Cool Vita"]
names.each do |name|
  # Create Portfolio
  portfolio1 = Portfolio.new(name: name, company_name: name, service: service, industry: industry)
  portfolio1.logo.attach(io: Rails.root.join("public/portfolios/byd_logo.png").open, filename: "byd_logo.png")
  portfolio1.image.attach(io: Rails.root.join("public/portfolios/byd_image.png").open, filename: "byd_image.png")
  portfolio1.image1.attach(io: Rails.root.join("public/portfolios/byd_image1.png").open, filename: "byd_image1.png")
  portfolio1.image2.attach(io: Rails.root.join("public/portfolios/byd_image2.png").open, filename: "byd_image2.png")
  portfolio1.banner.attach(io: Rails.root.join("public/portfolios/byd_banner.png").open, filename: "byd_banner.png")

  portfolio1.caption = "A closer look at how we transformed bold ideas into a powerful out-of-home campaign."
  portfolio1.short_description = "BYD (Build Your Dreams) is a global electric vehicle leader making bold strides in Indonesia’s transition to sustainable mobility."
  portfolio1.description = "As one of the automotive brands entering the Indonesian market starting in 2022, BYD brings its expertise in EV technology, energy storage, and green innovation to support the nation’s clean energy goals."
  portfolio1.about_campaign = %q{
      <p>This BYD campaign was launched on VERSELED, our high-impact LED screen located in Pantai Indah Kapuk (PIK), North Jakarta, a thriving lifestyle and commercial hub. The location offers high traffic volume and wide audience reach, attracting diverse demographics including professionals, families, and trend-conscious urbanites.</p>
      <p>By placing the campaign in this strategic area, the brand effectively captured attention across multiple audience segments, maximizing visibility and engagement in one of Jakarta’s most dynamic districts.</p>
  }
  portfolio1.area_coverage = %q{
    <p>The campaign was strategically placed in Pantai Indah Kapuk (PIK), North Jakarta, a bustling lifestyle and commercial district known for its high foot traffic and constant vehicle flow. As one of Jakarta’s trendiest hotspots, PIK offers strong visibility among urban professionals, families, and younger audiences.</p>
    <p>Its mix of shopping, dining, and entertainment venues made it an ideal backdrop for showcasing BYD's campaign, ensuring it reached both intentional and incidental viewers in a high-engagement environment.</p>
  }
  portfolio1.creative_highlights = %q{
    <p>Striking LED visuals: Large, high-resolution digital screens showcasing sleek, high-contrast visuals designed to capture attention quickly.</p>
    <p>Strategic roadside placement: Located near toll gates and major driving routes to ensure high visibility among daily commuters.</p>
    <p>High brightness & clarity: Optimized for both day and night viewing, delivering standout visuals around the clock.</p>
    <p>Urban lifestyle context: Placed in trend-forward zones like PIK to align the brand with aspirational, modern living.</p>
    <p>Impact at speed: Content designed to communicate key messages clearly, even at a glance from moving vehicles.</p>
  }
  Mobility.with_locale(:id) {
    portfolio1.caption = "Melihat lebih dekat bagaimana kami mengubah ide-ide berani menjadi kampanye luar rumah yang kuat."
    portfolio1.short_description = "BYD (Build Your Dreams) merupakan pemimpin global di bidang kendaraan listrik yang kini turut mendorong transisi mobilitas berkelanjutan di Indonesia."
    portfolio1.description = "Sejak memasuki pasar otomotif Indonesia pada 2022, BYD menghadirkan keahliannya dalam teknologi EV, penyimpanan energi, dan inovasi ramah lingkungan untuk mendukung target energi bersih nasional."
    portfolio1.about_campaign = %q{
      <p>Iklan BYD ini dibuat untuk membangun kesadaran dan visibilitas seiring dengan meluasnya kehadiran perusahaan ini di Indonesia. Diluncurkan di VERSELED, layar LED dengan dampak tinggi milik kami di Pantai Indah Kapuk (PIK), Jakarta Utara, iklan BYD ditempatkan di jantung kehidupan urban dan pusat perbelanjaan. Dengan keramaian yang konstan dan berbagai kategori audiens, mulai dari profesional, keluarga, hingga orang kota dengan pengetahuan trend tinggi, lokasi ini menghadirkan media yang ideal untuk visibilitas.</p>
      <p>Dengan penempatan yang strategis, kampanye ini sukses memperkenalkan BYD kepada lebih banyak orang, membangkitkan rasa ingin tahu dan meningkatkan pengenalan akan brand di salah satu kawasan Jakarta yang paling hidup dan ramai aktivitas.</p>
    }
    portfolio1.area_coverage = %q{
      <p>Iklan BYD ditempatkan secara strategis di Pantai Indah Kapuk (PIK) Jakarta Utara, sebuah kawasan gaya hidup dan komersial yang ramai, dikenal dengan lalu lintas pejalan kaki dan kendaraan yang tinggi. Sebagai salah satu destinasi paling trendi di Jakarta, PIK menawarkan visibilitas yang kuat di kalangan profesional urban, keluarga, dan audiens muda.</p>
      <p>Kombinasi pusat perbelanjaan, kuliner, dan hiburan menjadikan area ini lokasi yang ideal untuk menampilkan billboard BYD, dan menjangkau audiens, mulai dari yang secara aktif memperhatikan hingga yang hanya melintas di tengah kesibukan sehari-hari.</p>
    }
    portfolio1.creative_highlights = %q{
      <p>Visual LED yang memikat: Layar digital berukuran besar dengan resolusi tinggi, menampilkan visual kontras dan tajam untuk menarik perhatian secara cepat.</p>
      <p>Penempatan strategis di tepi jalan: Berada di dekat gerbang tol dan jalur utama agar mudah terlihat oleh para pengendara setiap hari.</p>
      <p>Kecerahan dan kejernihan optimal: Disesuaikan untuk tampilan siang maupun malam, menghadirkan visual yang menonjol sepanjang waktu.</p>
      <p>Konteks gaya hidup urban: Ditempatkan di area trendi seperti PIK untuk selaras dengan citra hidup modern yang aspiratif.</p>
      <p>Efektif dalam kecepatan: Konten dirancang agar pesan utama tersampaikan jelas, bahkan sekilas dari kendaraan yang melintas.</p>
    }
  }
  portfolio1.media_used = "Curved Horizontal LED"
  portfolio1.save!
  puts "Create Portfolio: #{portfolio1.name}"
end

