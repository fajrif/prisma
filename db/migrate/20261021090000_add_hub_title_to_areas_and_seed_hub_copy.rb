# Section area di hub Jakarta (sheet SEO 19 Oct, Step 1 dan Step 4): hub memuat 9 section
# H2 per area, jadi area perlu judul H2 opsional (`hub_title`) dan deskripsi per area.
# - Kolom `areas.hub_title` (jsonb, translatable); kosong = "Billboard di {area}".
# - Mengisi judul hanya untuk dua pengecualian sheet (Jakarta Timur, Tangerang Selatan).
# - Mengisi `areas.description` (ID, EN) hanya bila masih kosong.
# - Mengganti `locations.description` hub Jakarta (paragraf utama) hanya bila ID-nya masih
#   teks lama yang di-seed; teks yang sudah diedit tim tidak ditimpa.
# Aman dijalankan ulang.
class AddHubTitleToAreasAndSeedHubCopy < ActiveRecord::Migration[7.1]
  class MigrationArea < ActiveRecord::Base
    self.table_name = 'areas'
  end

  class MigrationLocation < ActiveRecord::Base
    self.table_name = 'locations'
  end

  # slug area => deskripsi [id, en] dan judul H2 [id, en] bila berbeda dari "Billboard di {area}".
  AREAS = {
    'jakarta-pusat' => {
      description: ['Jakarta Pusat adalah pusat pemerintahan dan bisnis Indonesia, dengan Sudirman–Thamrin sebagai koridor tersibuk. Prisma memiliki videotron dan billboard statis di jalan protokol, kawasan perkantoran, dan pusat belanja di area ini.',
                    'Central Jakarta is Indonesia\'s government and business centre, with Sudirman–Thamrin as its busiest corridor. Prisma runs videotrons and static billboards on its main roads, office districts and shopping areas.']
    },
    'jakarta-selatan' => {
      description: ['Jakarta Selatan memadukan perkantoran, mal, dan kawasan gaya hidup dengan audiens urban berdaya beli tinggi. Area ini cocok untuk brand gaya hidup, ritel, dan teknologi.',
                    'South Jakarta combines offices, malls and lifestyle districts with high-spending urban audiences. A good fit for lifestyle, retail and technology brands.']
    },
    'jakarta-barat' => {
      description: ['Billboard statis Prisma di Jakarta Barat berada di akses tol dan jalan raya padat yang dilalui komuter dari Tangerang menuju pusat kota, efektif untuk iklan brand dengan frekuensi tinggi.',
                    'Prisma\'s static billboards in West Jakarta sit on toll access points and busy main roads used by commuters from Tangerang into the city centre, effective for high-frequency brand advertising.']
    },
    'jakarta-utara' => {
      description: ['Jakarta Utara adalah area dengan videotron terbanyak di jaringan Prisma, dari kawasan premium PIK hingga jalur LRT Kelapa Gading.',
                    'North Jakarta has the most videotrons in Prisma\'s network, from the premium PIK district to the Kelapa Gading LRT line.']
    },
    'jakarta-timur' => {
      description: ['Di Jakarta Timur, Prisma hadir di kawasan Pulomas: videotron di persimpangan Perintis Kemerdekaan dekat Bella Terra dan di Jakarta International Velodrome di jalur LRT, serta billboard statis di Kayu Putih. Lokasi ini menjangkau warga sekitar, pengguna LRT, dan pengunjung venue olahraga.',
                    'In East Jakarta, Prisma covers the Pulomas area: videotrons at the Perintis Kemerdekaan intersection near Bella Terra and at the Jakarta International Velodrome on the LRT line, plus a static billboard in Kayu Putih. These sites reach local residents, LRT riders and sports-venue visitors.'],
      hub_title: ['Billboard di Jakarta Timur (Pulomas)', 'Billboards in East Jakarta (Pulomas)']
    },
    'tangerang' => {
      description: ['Billboard Prisma di Tangerang berada di koridor Tol Jakarta–Tangerang, salah satu jalur tol dengan traffic tertinggi, dengan estimasi hingga 291.000 impresi per hari. Cocok untuk brand yang menyasar pekerja dan keluarga.',
                    'Prisma\'s Tangerang billboards sit on the Jakarta–Tangerang toll corridor, one of the busiest toll roads, with up to an estimated 291,000 impressions a day. A good fit for brands targeting workers and families.']
    },
    'tangerang-selatan' => {
      description: ['Billboard 6 × 18 m dua arah di Jl. Raya Serpong menghubungkan Alam Sutera dan BSD, kawasan hunian, kampus, dan perkantoran yang terus berkembang di Tangerang Selatan.',
                    'Two-way 6 × 18 m billboards on Jl. Raya Serpong link Alam Sutera and BSD, a fast-growing area of homes, campuses and offices in South Tangerang.'],
      hub_title: ['Billboard di Tangerang Selatan (BSD & Alam Sutera)', 'Billboards in South Tangerang (BSD & Alam Sutera)']
    },
    'bekasi' => {
      description: ['Di Bekasi Barat, Prisma memiliki dua billboard statis berukuran 6 × 30 m di Jl. Ahmad Yani, menghadap arus kendaraan menuju Summarecon Bekasi dan Exit Tol Bekasi Barat. Lokasi ini menjangkau komuter dan kawasan komersial Bekasi.',
                    'In West Bekasi, Prisma has two 6 × 30 m static billboards on Jl. Ahmad Yani, facing traffic towards Summarecon Bekasi and the Bekasi Barat toll exit. Advertise here to reach commuters and Bekasi\'s commercial district.']
    },
    'depok' => {
      description: ['Billboard 12 × 6 m di persimpangan Jl. Raya Bogor dan Jl. Ir. H. Juanda menjangkau arus kendaraan antara Depok, Jakarta Timur, dan Bogor.',
                    'A 12 × 6 m billboard at the Jl. Raya Bogor and Jl. Ir. H. Juanda intersection reaches traffic between Depok, East Jakarta and Bogor.']
    }
  }.freeze

  OLD_INTRO_PREFIX = 'Lokasi kami di Jakarta mencakup'.freeze
  INTRO = [
    'Prisma Advertising mengelola 72 lokasi billboard Jakarta dan sekitarnya, terdiri dari billboard statis dan 21 videotron yang tersebar di 9 area Jabodetabek, dari Sudirman–Thamrin dan Senayan hingga PIK, Kebon Jeruk, dan koridor Tol Jakarta–Tangerang. Setiap lokasi dilengkapi ukuran, format, dan estimasi impresi per hari, sehingga Anda bisa memilih lokasi strategis sesuai target audiens, lalu sewa billboard Jakarta langsung bersama tim kami.',
    'Prisma Advertising manages 72 billboard locations in Jakarta and the surrounding area: static billboards and 21 videotrons across 9 areas of Greater Jakarta, from Sudirman–Thamrin and Senayan to PIK, Kebon Jeruk and the Jakarta–Tangerang toll corridor. Each location lists its size, format and estimated daily impressions, so you can choose strategic locations that match your target audience, then book a Jakarta billboard directly with our team.'
  ].freeze

  def up
    add_column :areas, :hub_title, :jsonb, null: false, default: {} unless column_exists?(:areas, :hub_title)
    MigrationArea.reset_column_information

    location = MigrationLocation.find_by(slug: 'jakarta')
    return unless location

    MigrationArea.where(location_id: location.id).find_each do |area|
      data = AREAS[area.slug]
      next unless data

      area.description = merge_blank(area.description, data[:description])
      area.hub_title = merge_blank(area.hub_title, data[:hub_title]) if data[:hub_title]
      area.save! if area.changed?
    end

    seed_intro(location)
  end

  def down
    remove_column :areas, :hub_title if column_exists?(:areas, :hub_title)
  end

  private

  # Isi id/en hanya bila belum ada nilainya.
  def merge_blank(current, (id_text, en_text))
    current = (current || {}).dup
    current['id'] = id_text if current['id'].blank?
    current['en'] = en_text if current['en'].blank?
    current
  end

  def seed_intro(location)
    current = (location.description || {}).dup
    return unless current['id'].to_s.start_with?(OLD_INTRO_PREFIX)

    current['id'], current['en'] = INTRO
    location.update_columns(description: current)
  end
end
