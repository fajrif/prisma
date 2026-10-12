# Keputusan strategist (2026-10): nama di schema boleh berbeda dari nama yang tampil.
#   - services.schema_name: nama untuk schema Service (mis. "Sewa Billboard Statis"); kosong = pakai `name`.
#   - awards.schema_text: teks penghargaan lengkap hanya untuk schema; halaman Innovations tetap memakai `name`.
class AddSchemaNameToServicesAndSchemaTextToAwards < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :schema_name, :jsonb, default: {}
    add_column :awards, :schema_text, :string
  end
end
