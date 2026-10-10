# Tanggal "diperbarui" yang diatur manual dari admin untuk artikel & campaign.
#
# Sebelumnya lastmod di sitemap, dateModified di schema, dan label "Diperbarui" diambil
# dari updated_at. Tim SEO sering menyimpan ulang artikel hasil migrasi WordPress hanya
# untuk merapikan tampilan, sehingga updated_at bergeser tanpa ada perubahan isi.
# updated_at kini hanya untuk keperluan record.
#
# Sengaja tidak di-backfill dari updated_at: justru nilai itu yang tidak bisa dipercaya.
class AddModifiedDateToArticlesAndPortfolios < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :modified_date, :datetime
    add_column :portfolios, :modified_date, :datetime
  end
end
