# Memindahkan fakta Organization dari config/seo/organization.yml (dihapus) ke tabel settings.
# Hanya mengisi kolom yang masih kosong, jadi aman dijalankan ulang dan tidak menimpa isian
# tim SEO. Nilai ditulis langsung di sini (bukan dibaca dari file) agar migrasi tetap jalan
# walau YAML sudah tidak ada.
class SeedOrganizationProfileIntoSettings < ActiveRecord::Migration[7.1]
  class MigrationSetting < ActiveRecord::Base
    self.table_name = 'settings'
  end

  PROFILE = {
    'brand_name' => 'Prisma Advertising',
    'founding_year' => '2004',
    'alternate_names' => ['Prisma Ads'],
    'knows_about' => ['Billboard advertising', 'Videotron', 'Digital out-of-home (DOOH)', 'Transit advertising',
                      'Creative OOH', '3D anamorphic content'],
    'area_served' => [
      { 'type' => 'City', 'name' => 'Jakarta' },
      { 'type' => 'City', 'name' => 'Bandung' },
      { 'type' => 'AdministrativeArea', 'name' => 'Bali' }
    ],
    'contact_points' => [
      { 'contact_type' => 'sales', 'telephone' => '+62-811-1306-888', 'email' => 'sales@prisma-ads.com',
        'area_served' => 'ID', 'available_language' => %w[id en] },
      { 'contact_type' => 'customer service', 'telephone' => '+62-21-5835-6575', 'email' => 'info@prisma-ads.com',
        'area_served' => 'ID', 'available_language' => %w[id en] }
    ],
    'sub_organizations' => [
      { 'id' => 'https://pixcreativemindworks.com/#organization', 'name' => 'PiX Creative Mindworks',
        'url' => 'https://pixcreativemindworks.com/' },
      { 'id' => 'https://boostad.co.id/#organization', 'name' => 'BoostAD', 'url' => 'https://boostad.co.id/' }
    ]
  }.freeze
  LEGAL_NAME = 'PT Prisma Harapan'.freeze

  def up
    MigrationSetting.reset_column_information
    setting = MigrationSetting.first || MigrationSetting.new
    PROFILE.each { |attr, value| setting[attr] = value if setting[attr].blank? }
    # Data lama menyimpan nama dagang sebagai legal_name; badan hukum yang benar PT Prisma Harapan.
    setting.legal_name = LEGAL_NAME if setting.legal_name.blank? || setting.legal_name == setting.brand_name
    setting.save!
  end

  def down; end
end
