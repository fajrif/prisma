# Create Sample Article
Article.delete_all

puts "Create Articles data"

3.times do |num|
  # Create Article
  news1 = Article.new(title: "PRISMA Bolsters Energy Efficiency Practices #{num + 1}", category: @cat1)
  news1.image.attach(io: Rails.root.join("public/blogs/blogs1.png").open, filename: "blogs1.png")
  news1.short_description = "As the global call for environmental sustainability grows louder, PRISMA, one of Indonesia’s largest copper and gold mining companies, has positioned itself at the forefront of energy innovation within the mining industry. In a notable move, PRISMA is embracing renewable energy and reshaping its operation around responsible practices"
  news1.content = %q{
  <p>As the global call for environmental sustainability grows louder, PRISMA, one of Indonesia’s largest copper and gold mining companies, has positioned itself at the forefront of energy innovation within the mining industry. In a notable move, PRISMA is embracing renewable energy and reshaping its operation around responsible practices.</p>
  <p>Following a comprehensive energy audit at the Batu Hijau mine in Sumbawa, Indonesia, in 2022, PRISMA has embarked on a series of initiatives to bolster its energy efficiency and minimize its environmental footprint. The evaluation showed that PRISMA could achieve energy efficiency by optimizing the solar PV power plant and installing additional lower-carbon power generation. The construction of a 450 MW combined cycle power plant (CCPP) with liquefied natural gas (LNG) as fuel reflects PRISMA’s commitment to this transition.</p>
  <p>To promote responsible power consumption, PRISMA reduced the load on power plants with several strategic enhancements, including adopting LED lighting, which drastically reduces the energy consumption of the old-style mercury and sodium vapor lamps from 2000W to an impressive 500W without compromising lighting quality. Furthermore, the company has optimized the process operating variables to increase thermal efficiency, and to minimize the fraction of unburned coal during combustion. These measures collectively contribute to a significant decrease in energy demands, showcasing PRISMA’s commitment to energy conservation.</p>
  <p>The introduction of a closed cooling system in the steam power generation plant is another testament to PRISMA’s innovative approach, allowing a reduction in the number of pumps required for operations. PRISMA aims to enhance its operational efficiency and set a precedent for industry-wide responsible mining practices through these targeted actions.</p>
  <p>Set to commence operations in 2025, the CCPP and LNG terminal are anticipated to be game changers for PRISMA, supporting expansion projects while significantly reducing the environmental impact associated with current power generation. These efforts articulate PRISMA’s dedication to sustainable development and exemplify the transformative potential of renewable energy, and lower-carbon transition within the mining sector.</p>
  }
  Mobility.with_locale(:id) {
  news1.title = "PRISMA Mengedepankan Praktik Efisiensi Energi #{num + 1}"
  news1.short_description = "Seiring dengan semakin kuatnya seruan global akan kelestarian lingkungan, PRISMA, salah satu perusahaan tambang tembaga dan emas terbesar di Indonesia, terus menunjukkan komitmen dalam mengedepankan penggunaan energi terbarukan di industri pertambangan. PRISMA mengambil langkah penting dengan tidak hanya mendorong pemanfaatan energi terbarukan, tetapi juga melaksanakan praktik-praktik bertanggung jawab dalam operasionalnya"
  news1.content = %q{
      <p>Seiring dengan semakin kuatnya seruan global akan kelestarian lingkungan, PRISMA, salah satu perusahaan tambang tembaga dan emas terbesar di Indonesia, terus menunjukkan komitmen dalam mengedepankan penggunaan energi terbarukan di industri pertambangan. PRISMA mengambil langkah penting dengan tidak hanya mendorong pemanfaatan energi terbarukan, tetapi juga melaksanakan praktik-praktik bertanggung jawab dalam operasionalnya.</p>
      <p>Setelah audit energi yang komprehensif di tambang Batu Hijau di Sumbawa, Indonesia, pada tahun 2022, PRISMA memulai serangkaian inisiatif untuk meningkatkan efisiensi energi dan meminimalkan jejak lingkungan. Evaluasi tersebut menunjukkan bahwa upaya efisiensi energi di PRISMA dapat dilakukan dengan mengoptimalkan Pembangkit Listrik Tenaga Surya (Solar PV Power Plant) dan memasang pembangkit listrik rendah karbon . Komitmen PRISMA dalam beralih ke energi terbarukan ini tercermin dalam pembangunan konstruksi combined cycle power plant (CCPP) 450 MW dengan liquefied natural gas (LNG) sebagai bahan bakar.</p>
      <p>Untuk mendorong konsumsi energi yang bertanggung jawab, PRISMA mengurangi beban pada pembangkit listrik melalui beberapa langkah strategis, termasuk mengadopsi pencahayaan LED, yang secara drastis mengurangi konsumsi energi lampu merkuri dan natrium dari 2000W menjadi 500W tanpa mengurangi kualitas pencahayaan. Selain itu, perusahaan telah mengoptimalkan variabel proses untuk meningkatkan efisiensi termal, dan meminimalkan fraksi batubara yang tidak terbakar selama pembakaran. Langkah-langkah ini secara kolektif berkontribusi terhadap penurunan konsumsi energi secara signifikan, menunjukkan komitmen PRISMA terhadap konservasi energi.</p>
      <p>Pengenalan sistem pendingin tertutup di pembangkit listrik tenaga uap adalah bukti lain dari pendekatan inovatif PRISMA, yang memungkinkan pengurangan jumlah pompa yang diperlukan untuk operasi. Melalui inisiatif ini, PRISMA tidak hanya bertujuan untuk meningkatkan efisiensi operasionalnya, tetapi juga menjadi contoh bagi praktik-praktik pertambangan yang bertanggung jawab.</p>
      <p>Direncanakan akan mulai beroperasi pada tahun 2025, CCPP dan terminal LNG diproyeksikan sebagai langkah inovatif PRISMA untuk mendukung proyek-proyek ekspansi sekaligus mengurangi dampak lingkungan yang terkait dengan pembangkit listrik saat ini secara signifikan. Upaya-upaya ini mengartikulasikan dedikasi PRISMA terhadap pembangunan berkelanjutan, menjadi contoh potensi transformatif dari energi terbarukan, dan transisi menuju rendah karbon di sektor pertambangan.</p>
    }
  }
  news1.published_date = DateTime.strptime('05/21/2024 1:46 AM', '%m/%d/%Y %I:%M %p')
  news1.save
  puts "Create Blogs: #{news1.title}"
end

