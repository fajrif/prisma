# Sub area: neighbourhood di dalam satu area (mis. Sudirman–Thamrin di Jakarta Pusat).
# Menjadi judul H3 pada daftar titik di halaman area, dikelompokkan per sub_area.
# `key` ident stabil (parameterize, tidak berubah walau judul diedit); nama & deskripsi
# diterjemahkan (ID/EN; CN jatuh ke EN).
class CreateSubAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_areas do |t|
      t.references :area, null: false, foreign_key: true
      t.string :key, null: false, default: ''
      t.jsonb :name, null: false, default: {}
      t.jsonb :description, null: false, default: {}
      t.integer :position, null: false, default: 0
      t.timestamps
    end
    add_index :sub_areas, %i[area_id key], unique: true

    add_reference :products, :sub_area, foreign_key: true
  end
end
