# Mengisi Area awal dari kolom products.city (satu area per kombinasi location + city),
# lalu products.area_id. Hanya mengisi yang masih kosong, jadi aman dijalankan ulang dan
# tidak menimpa pengelompokan yang sudah diubah tim SEO di admin.
class SeedAreasFromProductCity < ActiveRecord::Migration[7.1]
  class MigrationArea < ActiveRecord::Base
    self.table_name = 'areas'
  end

  class MigrationProduct < ActiveRecord::Base
    self.table_name = 'products'
  end

  def up
    rows = MigrationProduct.where(area_id: nil).where.not(location_id: nil)
                           .group(:location_id, :city).count

    rows.group_by { |(location_id, _), _| location_id }.each do |location_id, entries|
      # Area dengan titik terbanyak di urutan pertama.
      entries.sort_by { |(_, city), count| [-count, city.to_s] }.each do |(_, city), _count|
        name = city.to_s.strip.presence || 'Lainnya'
        area = MigrationArea.find_or_create_by!(location_id: location_id, name: name) do |a|
          a.slug = name.parameterize
          a.position = MigrationArea.where(location_id: location_id).maximum(:position).to_i + 1
        end

        scope = MigrationProduct.where(area_id: nil, location_id: location_id)
        scope = city.to_s.strip.present? ? scope.where(city: city) : scope.where(city: [nil, ''])
        scope.update_all(area_id: area.id)
      end
    end
  end

  def down
    # Data saja; tabel dihapus oleh migrasi sebelumnya bila di-rollback.
  end
end
