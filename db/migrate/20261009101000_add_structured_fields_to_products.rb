# Field terstruktur untuk schema Place pada halaman billboard (T5/T12).
#
# Sebelumnya semua informasi ini hanya ada sebagai teks bebas di `specification`
# ("6m (h) x 30m (w) - Front Light") dan `est_impression` ("133.376 impression/day"),
# sehingga tidak bisa dipakai sebagai properti schema yang terpisah.
#
# Format dan orientasi TIDAK dibuatkan kolom karena sudah bisa diturunkan dari
# `product_category` (7 kategori, 100% konsisten dengan enum `billboard_type`).
#
# Nilai awal diisi rake task `seo:backfill_billboards` sebagai draft; tim SEO
# Strategist mengoreksinya lewat admin.
class AddStructuredFieldsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :city, :string, default: '', null: false
    add_column :products, :region, :string, default: '', null: false
    add_column :products, :size, :string, default: '', null: false
    add_column :products, :lighting, :string, default: '', null: false
    add_column :products, :slot_duration, :string, default: '', null: false
    add_column :products, :operating_hours, :string, default: '', null: false
    add_column :products, :impressions_per_day, :integer
  end
end
