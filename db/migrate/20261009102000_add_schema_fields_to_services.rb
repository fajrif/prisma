# Field schema untuk halaman layanan (prisma-schema-spec.md bagian 2).
#
# Sebelumnya `serviceType` diambil dari kolom `caption`, yang isinya tagline
# marketing ("Command Attention with High-Impact Static Billboard Advertising")
# dan bukan kategori layanan seperti yang diminta schema.org.
#
# `area_served` per layanan juga belum ada; semuanya di-hardcode "Indonesia".
# `schema_provider_url` hanya dipakai layanan PiX, yang penyedianya organisasi lain.
class AddSchemaFieldsToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :service_type, :string, default: '', null: false
    add_column :services, :area_served, :jsonb, default: []
    add_column :services, :schema_provider_url, :string, default: '', null: false
  end
end
