# Fakta schema Organization yang sebelumnya ada di config/seo/organization.yml (kini dihapus)
# disimpan di Company Profile supaya tim SEO bisa mengubahnya tanpa developer. Data awal diisi
# oleh migrasi berikutnya (SeedOrganizationProfileIntoSettings).
class AddOrganizationProfileToSettings < ActiveRecord::Migration[7.1]
  def change
    change_table :settings, bulk: true do |t|
      t.string :brand_name, default: '', null: false
      t.string :founding_year, default: '', null: false
      t.jsonb :alternate_names, default: []
      t.jsonb :knows_about, default: []
      t.jsonb :area_served, default: []
      t.jsonb :contact_points, default: []
      t.jsonb :sub_organizations, default: []
    end
  end
end
