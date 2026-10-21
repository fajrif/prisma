# Nama area kini diterjemahkan (sheet SEO 19 Oct: nama area tampil berbahasa Inggris di /en,
# mis. "Jakarta Pusat" → "Central Jakarta"). Kolom string menjadi jsonb seperti field Mobility
# lain; index unique (location_id, name) tidak bisa dipakai untuk jsonb → dilepas, keunikan
# divalidasi di aplikasi (Area#uniqueness_of_name_within_location).
class ChangeAreasNameToJsonb < ActiveRecord::Migration[7.1]
  def up
    remove_index :areas, %i[location_id name]
    change_column_default :areas, :name, from: '', to: nil

    # Nilai lama disimpan sebagai id (bahasa asli) sekaligus en (perilaku lama: nama sama di
    # semua bahasa) sampai diisi terjemahannya lewat admin.
    execute <<~SQL.squish
      ALTER TABLE areas
      ALTER COLUMN name TYPE jsonb
      USING (CASE WHEN name = '' THEN '{}'::jsonb
                  ELSE jsonb_build_object('id', name, 'en', name) END)
    SQL
    # SQL langsung: change_column_default `to: {}` dibaca sebagai hash opsi dan menyimpan {"to":{}}.
    execute "ALTER TABLE areas ALTER COLUMN name SET DEFAULT '{}'::jsonb"
    change_column_null :areas, :name, false
  end

  def down
    execute "ALTER TABLE areas ALTER COLUMN name DROP DEFAULT"
    # Nilai per bahasa diratakan ke satu string (id menang bila ada).
    execute <<~SQL.squish
      ALTER TABLE areas
      ALTER COLUMN name TYPE text
      USING (COALESCE(name->>'id', name->>'en', ''))
    SQL
    change_column_default :areas, :name, from: nil, to: ''
    add_index :areas, %i[location_id name], unique: true
  end
end
