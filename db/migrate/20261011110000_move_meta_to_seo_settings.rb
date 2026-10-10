# Satukan meta title/description ke seo_settings.
#
# Sebelumnya dua tempat: kolom model (Page, Article, Industry, Portfolio, Service) dan panel
# "SEO & Social" (seo_settings). Keduanya mengisi <title>/<meta description>; seo_settings
# mengalahkan kolom model. Kini seo_settings satu-satunya sumber.
#
# Aman: hanya MENYALIN (kunci jsonb mentah per bahasa, tanpa fallback Mobility) dan hanya
# mengisi field seo_settings yang masih kosong. Kolom lama TIDAK dihapus/diubah sehingga ada
# jalur mundur; `down` tidak menghapus apa pun (nilai yang sempat diedit sesudah migrasi
# tetap berada di seo_settings).
class MoveMetaToSeoSettings < ActiveRecord::Migration[7.1]
  TABLES = { 'Page' => 'pages', 'Article' => 'articles', 'Industry' => 'industries',
             'Portfolio' => 'portfolios', 'Service' => 'services' }.freeze

  def up
    TABLES.each do |type, table|
      created = exec_update(<<~SQL.squish, 'move_meta_insert')
        INSERT INTO seo_settings (seoable_type, seoable_id, meta_title, meta_description, created_at, updated_at)
        SELECT '#{type}', t.id, COALESCE(t.meta_title, '{}'::jsonb), COALESCE(t.meta_description, '{}'::jsonb), NOW(), NOW()
        FROM #{table} t
        WHERE (COALESCE(t.meta_title, '{}'::jsonb) <> '{}'::jsonb OR COALESCE(t.meta_description, '{}'::jsonb) <> '{}'::jsonb)
          AND NOT EXISTS (SELECT 1 FROM seo_settings s WHERE s.seoable_type = '#{type}' AND s.seoable_id = t.id)
      SQL

      filled = exec_update(<<~SQL.squish, 'move_meta_fill')
        UPDATE seo_settings s
        SET meta_title = CASE WHEN COALESCE(s.meta_title, '{}'::jsonb) = '{}'::jsonb THEN COALESCE(t.meta_title, '{}'::jsonb) ELSE s.meta_title END,
            meta_description = CASE WHEN COALESCE(s.meta_description, '{}'::jsonb) = '{}'::jsonb THEN COALESCE(t.meta_description, '{}'::jsonb) ELSE s.meta_description END,
            updated_at = NOW()
        FROM #{table} t
        WHERE s.seoable_type = '#{type}' AND s.seoable_id = t.id
          AND ((COALESCE(s.meta_title, '{}'::jsonb) = '{}'::jsonb AND COALESCE(t.meta_title, '{}'::jsonb) <> '{}'::jsonb)
            OR (COALESCE(s.meta_description, '{}'::jsonb) = '{}'::jsonb AND COALESCE(t.meta_description, '{}'::jsonb) <> '{}'::jsonb))
      SQL

      say "#{type}: #{created} seo_settings baru, #{filled} diisi dari kolom model", true
    end
  end

  def down
    say 'Tidak ada yang dihapus: kolom model tidak pernah diubah, seo_settings dibiarkan.', true
  end
end
