# Client menyetujui perubahan URL hub /locations/jabodetabek -> /locations/jakarta
# (message_from_client.md, 8 Okt 2026). Hanya slug yang berubah; nama tampilan
# "Jabodetabek" dibiarkan karena copy hub baru menyusul di T13.
#
# FriendlyId pada Location memakai `use: :slugged` tanpa modul :history, jadi slug
# lama tidak tersimpan di mana pun — URL lama ditangani lewat redirect 301 di routes.
class RenameJabodetabekLocationSlug < ActiveRecord::Migration[7.1]
  def up
    execute <<~SQL
      UPDATE locations SET slug = 'jakarta', updated_at = NOW()
      WHERE slug = 'jabodetabek'
    SQL
  end

  def down
    execute <<~SQL
      UPDATE locations SET slug = 'jabodetabek', updated_at = NOW()
      WHERE slug = 'jakarta'
    SQL
  end
end
