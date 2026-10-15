# Area: tingkat di antara hub (Location: Jakarta, Bandung, Bali) dan titik billboard (Product).
# Dipakai URL bertingkat /locations/{location}/{area}/{product}, halaman area, dan breadcrumb.
# Nama area tidak diterjemahkan (nama lokal: Jakarta Pusat, SCBD, PIK); hanya deskripsinya.
class CreateAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :areas do |t|
      t.references :location, null: false, foreign_key: true
      t.integer :banner_section_id
      t.string :name, null: false, default: ''
      t.jsonb :description, default: {}
      t.string :slug, null: false, default: ''
      t.integer :position, null: false, default: 0
      t.timestamps
    end
    add_index :areas, %i[location_id slug], unique: true
    add_index :areas, %i[location_id name], unique: true

    add_reference :products, :area, foreign_key: true
  end
end
