# Mengisi sub_area (neighbourhood) untuk hub Jakarta dari sheet SEO "Jakarta Hub Sheet
# Update 19 Oct" (tab "Site → sub_area" + baris Neighbourhood), lalu:
# - memindahkan LED Senayan Trade Center ke Jakarta Selatan (catatan sheet: city di admin
#   masih "Jakarta Pusat"; semua titik Senayan harus satu area → Pusat 14, Selatan 13);
# - mengurutkan area mengikuti urutan chip sheet (Pusat, Selatan, Barat, Utara, Timur,
#   Tangerang, Tangsel, Bekasi, Depok);
# - menambahkan nama EN pada areas.name (nama lama dipertahankan sebagai id).
# Hanya mengisi yang masih kosong/id belum cocok, aman dijalankan ulang.
class SeedSubAreas < ActiveRecord::Migration[7.1]
  class MigrationArea < ActiveRecord::Base
    self.table_name = 'areas'
  end

  class MigrationSubArea < ActiveRecord::Base
    self.table_name = 'sub_areas'
  end

  class MigrationProduct < ActiveRecord::Base
    self.table_name = 'products'
  end

  # key, nama (id, en), deskripsi (id, en) — urutan = urutan H3 di sheet.
  SUB_AREAS = [
    ['jakarta-pusat', 'sudirman-thamrin', 'Sudirman – Thamrin', 'Sudirman – Thamrin',
     'Videotron besar di Chase Plaza (20 × 30 m), Wisma Bumiputera dan Menara Sudirman (24 × 12 m), serta MetaLED Djakarta Theater di Thamrin menjangkau eksekutif dan profesional setiap hari. Billboard statis di Sabang, dekat Sarinah, melengkapi kehadiran brand di pusat kota. Cocok untuk kampanye korporat dan peluncuran produk.',
     'Large videotrons at Chase Plaza (20 × 30 m), Wisma Bumiputera and Menara Sudirman (24 × 12 m), and MetaLED Djakarta Theater on Thamrin reach executives and professionals every day. A static billboard on Sabang, near Sarinah, rounds out your presence in the city centre. Ideal for corporate campaigns and product launches.'],
    ['jakarta-pusat', 'karet-tanah-abang', 'Karet & Tanah Abang', 'Karet & Tanah Abang',
     'Citywalk Sudirman dan Citylofts di Jl. KH Mas Mansyur memiliki billboard statis dua arah dan layar LED di jalur Sudirman–Tanah Abang, ditambah billboard di Wisma BNI 46, Karet Pasar Baru. Lokasi ini menjangkau pekerja kantoran dan arus kendaraan menuju Tanah Abang.',
     'Citywalk Sudirman and Citylofts on Jl. KH Mas Mansyur have two-way static billboards and an LED screen on the Sudirman–Tanah Abang route, plus a billboard at Wisma BNI 46, Karet Pasar Baru. These sites reach office workers and traffic heading to Tanah Abang.'],
    ['jakarta-pusat', 'harmoni-gajah-mada', 'Harmoni & Gajah Mada', 'Harmoni & Gajah Mada',
     'Layar LED di persimpangan Harmoni, dekat Istana Merdeka, dan billboard memanjang 2 × 25 m di ITC Roxy Mas menjangkau lalu lintas padat dari arah Gajah Mada dan Tomang.',
     'An LED screen at the Harmoni intersection, near Istana Merdeka, and a 2 × 25 m billboard at ITC Roxy Mas reach heavy traffic coming from Gajah Mada and Tomang.'],
    ['jakarta-selatan', 'senayan-gatot-subroto', 'Senayan & Gatot Subroto', 'Senayan & Gatot Subroto',
     'BRIN Grande LED di Gatot Subroto berukuran 20 × 35 m adalah salah satu layar terbesar di jaringan Prisma. Di Senayan, billboard 15 × 30 m dan layar LED di Senayan Trade Center serta billboard di Plaza Senayan menjangkau pengunjung mal dan pekerja di sekitar GBK.',
     "BRIN Grande LED on Gatot Subroto, at 20 × 35 m, is one of the largest screens in Prisma's network. In Senayan, a 15 × 30 m billboard and an LED screen at Senayan Trade Center and a billboard at Plaza Senayan reach mall visitors and office workers around GBK."],
    ['jakarta-selatan', 'casablanca-tebet', 'Casablanca & Tebet', 'Casablanca & Tebet',
     'Billboard di Kota Kasablanka dan Underpass Casablanca berada di salah satu koridor tersibuk menuju Kuningan, sementara lokasi di Tebet Eco Park menjangkau keluarga dan pengunjung taman kota.',
     'Billboards at Kota Kasablanka and the Casablanca underpass sit on one of the busiest routes into Kuningan, while the Tebet Eco Park site reaches families and park visitors.'],
    ['jakarta-selatan', 'blok-m-simatupang', 'Blok M, Cipulir & TB Simatupang', 'Blok M, Cipulir & TB Simatupang',
     'Layar LED di Taman Literasi dekat Stasiun MRT Blok M, billboard dua arah di ITC Cipulir Mas (Jl. Ciledug Raya), serta lokasi di Cilandak Town Square, Talavera Office Park, dan RPX Center di koridor TB Simatupang–Antasari. Billboard di seberang Cilandak Town Square mencatat estimasi hampir 400.000 impresi per hari.',
     'An LED screen at Taman Literasi near Blok M MRT station, two-way billboards at ITC Cipulir Mas (Jl. Ciledug Raya), and sites at Cilandak Town Square, Talavera Office Park and RPX Center on the TB Simatupang–Antasari corridor. The billboard opposite Cilandak Town Square reaches an estimated close to 400,000 impressions a day.'],
    ['jakarta-barat', 'kebon-jeruk-kedoya', 'Kebon Jeruk & Kedoya', 'Kebon Jeruk & Kedoya',
     'Exit Tol Kebon Jeruk (16 × 8 m, dua arah), Tol Jakarta–Merak KM 8 dari arah Puri dan Green Lake, serta Jl. Panjang, Jl. Perjuangan, Jl. Pesanggrahan, dan Jl. Kedoya Raya menjangkau kawasan hunian, rumah sakit, dan perkantoran.',
     'Kebon Jeruk toll exit (16 × 8 m, both directions), the Jakarta–Merak toll road at KM 8 from Puri and Green Lake, and Jl. Panjang, Jl. Perjuangan, Jl. Pesanggrahan and Jl. Kedoya Raya reach residential areas, hospitals and offices.'],
    ['jakarta-barat', 'tomang-slipi', 'Tomang, Tanjung Duren & Slipi', 'Tomang, Tanjung Duren & Slipi',
     'Flyover Tomang dan Flyover Tanjung Duren (8 × 16 m) berada di jalur utama dari Harmoni menuju tol, ditambah Pasar Slipi dan Season City Mall di Jl. Latumenten. Lokasi ini menjangkau arus kendaraan menuju Tanah Abang dan Grogol.',
     'Tomang and Tanjung Duren flyovers (8 × 16 m) sit on the main route from Harmoni to the toll road, plus Pasar Slipi and Season City Mall on Jl. Latumenten. These sites reach traffic heading to Tanah Abang and Grogol.'],
    ['jakarta-utara', 'pik', 'PIK & PIK 2', 'PIK & PIK 2',
     'Jaringan VerseLED di PIK Avenue menjangkau kendaraan dari exit tol, RS PIK, dan arah Tzu Chi, sementara layar LED di Blue Lagoon, Gold Lagoon, dan Cove Batavia hadir di PIK 2. Cocok untuk brand premium, properti, dan F&B yang ingin tampil di depan audiens dengan daya beli tinggi.',
     'The VerseLED network at PIK Avenue reaches traffic from the toll exit, RS PIK and the Tzu Chi side, while LED screens at Blue Lagoon, Gold Lagoon and Cove Batavia cover PIK 2. A good fit for premium, property and F&B brands that want to reach high-spending audiences.'],
    ['jakarta-utara', 'pluit-teluk-gong', 'Pluit & Teluk Gong', 'Pluit & Teluk Gong',
     'Billboard statis di Emporium Pluit (16 × 8 m), Jl. Teluk Gong Raya, dan Jl. Pakin menjangkau kawasan hunian dan komersial yang padat di Penjaringan.',
     'Static billboards at Emporium Pluit (16 × 8 m), Jl. Teluk Gong Raya and Jl. Pakin reach dense residential and commercial areas in Penjaringan.'],
    ['jakarta-utara', 'kelapa-gading', 'Kelapa Gading', 'Kelapa Gading',
     'Dua videotron di jalur LRT Jl. Boulevard Raya, di depan Mall Kelapa Gading, menjangkau keluarga, pengguna LRT, dan pengunjung mal. Cocok untuk brand ritel dan F&B.',
     'Two videotrons on the LRT line along Jl. Boulevard Raya, in front of Mall Kelapa Gading, reach families, LRT riders and mall visitors. A good fit for retail and F&B brands.'],
    ['tangerang', 'tol-jakarta-tangerang', 'Tol Jakarta–Tangerang & Alam Sutera', 'Jakarta–Tangerang Toll Road & Alam Sutera',
     'Billboard berukuran hingga 30 × 15 m di KM 9, KM 12, dan KM 14, di Gerbang Tol Alam Sutera, dan di Exit Tol Alam Sutera–Gading Serpong (10 × 20 m) menjangkau komuter harian di dua arah. Lokasi di akses Tol Bandara Soekarno-Hatta menambah jangkauan ke pelancong.',
     'Billboards up to 30 × 15 m at KM 9, KM 12 and KM 14, at the Alam Sutera toll gate and at the Alam Sutera–Gading Serpong toll exit (10 × 20 m) reach daily commuters in both directions. A site on the Soekarno-Hatta airport toll approach adds reach to travellers.'],
    ['tangerang', 'gading-serpong', 'Gading Serpong', 'Gading Serpong',
     'Dua billboard di Jl. MH Thamrin, Gading Serpong, menjangkau kendaraan dari dan menuju Jakarta, cocok untuk brand yang menyasar keluarga dan kawasan hunian baru.',
     'Two billboards on Jl. MH Thamrin, Gading Serpong, reach traffic to and from Jakarta, a good fit for brands targeting families and new residential areas.']
  ].freeze

  # slug produk → key sub_area (sheet tab "Site → sub_area"). Titik di Jakarta Timur,
  # Tangerang Selatan, Bekasi, dan Depok tanpa sub_area (kartu tampil langsung di bawah H2).
  PRODUCT_SUB_AREA = {
    'led-menara-sudirman' => 'sudirman-thamrin',
    'chase-smart-led-chase-plaza' => 'sudirman-thamrin',
    'hype-led-wisma-bumiputera' => 'sudirman-thamrin',
    'metaled-djakarta-theater' => 'sudirman-thamrin',
    'sabang-sarinah' => 'sudirman-thamrin',
    'citywalk-sudirman-sudirman-tanah-abang' => 'karet-tanah-abang',
    'led-citylofts-sudirman' => 'karet-tanah-abang',
    'jl-karet-pasar-baru-timur-wisma-bni-46-central-jakarta' => 'karet-tanah-abang',
    'citylofts-sudirman-sudirman-to-tanah-abang' => 'karet-tanah-abang',
    'citylofts-sudirman-tanah-abang-to-sudirman' => 'karet-tanah-abang',
    'citywalk-sudirman-tanah-abang-sudirman' => 'karet-tanah-abang',
    'citywalk-sudirman-tanah-abang-to-sudirman-2' => 'karet-tanah-abang',
    'led-harmoni-intersection' => 'harmoni-gajah-mada',
    'jl-kh-hasyim-ashari-itc-roxy-mas-central-jakarta' => 'harmoni-gajah-mada',
    'led-senayan-trade-center' => 'senayan-gatot-subroto',
    'senayan-trade-center' => 'senayan-gatot-subroto',
    'brin-grande-led-gatot-subroto' => 'senayan-gatot-subroto',
    'plaza-senayan' => 'senayan-gatot-subroto',
    'kota-kasablanka-mall' => 'casablanca-tebet',
    'underpass-casablanca' => 'casablanca-tebet',
    'tebet-eco-park' => 'casablanca-tebet',
    'cilandak-town-square-opposite' => 'blok-m-simatupang',
    'talavera-office-park' => 'blok-m-simatupang',
    'itc-cipulir-mas-ciledug-to-kebayoran' => 'blok-m-simatupang',
    'itc-cipulir-mas-kebayoran-to-ciledug' => 'blok-m-simatupang',
    'rpx-center' => 'blok-m-simatupang',
    'led-taman-literasi' => 'blok-m-simatupang',
    'jakarta-merak-toll-road-km-8-015a-west-jakarta' => 'kebon-jeruk-kedoya',
    'exit-toll-kebon-jeruk-tangerang-to-tomang' => 'kebon-jeruk-kedoya',
    'exit-toll-kebon-jeruk-tomang-to-tangerang' => 'kebon-jeruk-kedoya',
    'jl-panjang-west-jakarta-unifam-tower' => 'kebon-jeruk-kedoya',
    'jl-panjang-west-jakarta-emc-grha-kedoya-hospital' => 'kebon-jeruk-kedoya',
    'jl-perjuangan-west-jakarta-siloam-kebun-jeruk-hospital' => 'kebon-jeruk-kedoya',
    'jl-pesanggrahan-west-jakarta' => 'kebon-jeruk-kedoya',
    'jl-kedoya-raya-kedoya-elok-apartment' => 'kebon-jeruk-kedoya',
    'flyover-tanjung-duren' => 'tomang-slipi',
    'season-city-mall' => 'tomang-slipi',
    'flyover-tomang-harmoni-to-tomang' => 'tomang-slipi',
    'flyover-tomang-tomang-to-harmoni' => 'tomang-slipi',
    'pasar-slipi-kemanggisan-to-tanah-abang' => 'tomang-slipi',
    'pasar-slipi-tanah-abang-to-kemanggisan' => 'tomang-slipi',
    'verseled-multiply-pik-avenue' => 'pik',
    'verseled-pik-avenue-from-rs-pik' => 'pik',
    'verseled-multiply-pik-avenue-tzu-chi-to-pik-2' => 'pik',
    'verseled-multiply-pik-avenue-tzu-chi-to-pik-avenue' => 'pik',
    'verseled-pik-avenue-from-exit-tol' => 'pik',
    'led-blue-lagoon-pik-2' => 'pik',
    'led-gold-lagoon-pik-2' => 'pik',
    'led-cove-batavia-pik-2' => 'pik',
    'emporium-pluit' => 'pluit-teluk-gong',
    'grand-heaven-jakarta-apartment-mitra-bahari' => 'pluit-teluk-gong',
    'teluk-gong-jl-teluk-gong-raya' => 'pluit-teluk-gong',
    'led-mall-kelapa-gading-menara-bca-lrt' => 'kelapa-gading',
    'led-mall-kelapa-gading-gafoy-lrt' => 'kelapa-gading',
    'exit-toll-alam-sutera-and-gading-serpong' => 'tol-jakarta-tangerang',
    'jakarta-tangerang-toll-road-km-12-620-jakarta-to-tangerang' => 'tol-jakarta-tangerang',
    'bottleneck-airport-and-tol-kunciran-batuceper-cengkareng' => 'tol-jakarta-tangerang',
    'jakarta-tangerang-toll-road-km-12-620-tangerang-to-jakarta' => 'tol-jakarta-tangerang',
    'jakarta-tangerang-toll-road-km-14-950-alam-sutera-toll-gate' => 'tol-jakarta-tangerang',
    'jakarta-tangerang-toll-road-km-9-350-tangerang-to-jakarta' => 'tol-jakarta-tangerang',
    'rest-area-km-14-jakarta-tangerang-toll-road' => 'tol-jakarta-tangerang',
    'toll-gate-alam-sutera' => 'tol-jakarta-tangerang',
    'jl-mh-thamrin-jakarta-to-gading-serpong' => 'gading-serpong',
    'jl-mh-thamrin-gading-serpong-to-jakarta' => 'gading-serpong'
  }.freeze

  # Urutan chip sheet + nama EN per area hub Jakarta.
  AREA_ORDER = {
    'Jakarta Pusat' => ['Central Jakarta', 1],
    'Jakarta Selatan' => ['South Jakarta', 2],
    'Jakarta Barat' => ['West Jakarta', 3],
    'Jakarta Utara' => ['North Jakarta', 4],
    'Jakarta Timur' => ['East Jakarta', 5],
    'Tangerang' => ['Tangerang', 6],
    'Tangerang Selatan' => ['South Tangerang', 7],
    'Bekasi' => ['Bekasi', 8],
    'Depok' => ['Depok', 9]
  }.freeze

  def up
    location_id = ActiveRecord::Base.connection.select_value(
      ActiveRecord::Base.sanitize_sql_array(['SELECT id FROM locations WHERE slug = ?', 'jakarta'])
    )
    return unless location_id

    areas = MigrationArea.where(location_id: location_id)
    return if areas.empty?

    fix_led_senayan_trade_center(areas)
    update_area_names_and_positions(areas)
    seed_sub_areas(areas)
    assign_products
  end

  def down
    # Data saja; penghapusan kolom sub_area_id & tabel sub_areas oleh migrasi sebelumnya.
  end

  private

  # Catatan sheet 19 Oct: LED Senayan Trade Center ber-city "Jakarta Pusat" di admin, padahal
  # satu group dengan billboard statis STC & Plaza Senayan di Jakarta Selatan (Pusat 14, Selatan 13).
  def fix_led_senayan_trade_center(areas)
    product = MigrationProduct.find_by(slug: 'led-senayan-trade-center')
    selatan = areas.find_by(slug: 'jakarta-selatan')
    return unless product && selatan && product.area_id != selatan.id

    product.update_columns(city: 'Jakarta Selatan', area_id: selatan.id)
  end

  def update_area_names_and_positions(areas)
    areas.find_each do |area|
      en_name, position = AREA_ORDER[area.name['id'] || area.name['en']]
      next unless position

      area.update_columns(name: { 'id' => area.name['id'] || area.name['en'], 'en' => en_name },
                          position: position)
    end
  end

  def seed_sub_areas(areas)
    position_by_area = Hash.new(0)

    SUB_AREAS.each do |area_slug, key, name_id, name_en, desc_id, desc_en|
      area = areas.find_by(slug: area_slug)
      next unless area

      position_by_area[area.id] += 1
      sub_area = MigrationSubArea.find_or_initialize_by(area_id: area.id, key: key)
      # Hanya mengisi yang masih kosong; copy yang sudah diedit tim di admin tidak ditimpa.
      attrs = { name: { 'id' => name_id, 'en' => name_en },
                description: { 'id' => desc_id, 'en' => desc_en } }
      attrs[:position] = position_by_area[area.id] if sub_area.new_record?
      sub_area.assign_attributes(attrs)
      sub_area.save! if sub_area.new_record? || sub_area.changed?
    end
  end

  def assign_products
    keys = MigrationSubArea.pluck(:area_id, :key).to_h { |area_id, key| [key, area_id] }
    # slug → area_id sub_area-nya; cocokkan dengan area produk saat ini agar tidak salah kelompok.
    slug_to_area = PRODUCT_SUB_AREA.to_h do |slug, key|
      [slug, keys[key]]
    end

    MigrationProduct.where(slug: slug_to_area.keys).find_each do |product|
      area_id = slug_to_area[product.slug]
      # Lewati bila sub_area-nya bukan milik area produk (mis. data berubah di admin).
      next unless area_id && MigrationSubArea.where(area_id: area_id, key: PRODUCT_SUB_AREA[product.slug]).exists?
      next if product.sub_area_id && MigrationSubArea.find_by(id: product.sub_area_id)&.key == PRODUCT_SUB_AREA[product.slug]

      # Pastikan produk berada di area yang sama dengan sub_area-nya (mis. LED Senayan).
      product.update_columns(area_id: area_id) unless product.area_id == area_id
      product.update_columns(sub_area_id: MigrationSubArea.find_by(area_id: area_id, key: PRODUCT_SUB_AREA[product.slug]).id)
    end
  end
end
