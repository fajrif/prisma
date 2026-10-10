# Penempatan snippet (FAQ, tabel) di konten yang belum punya mekanisme section:
# Article, Location, Industry, Product. Pages tetap memakai sections, Services memakai segments.
class CreateContentBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :content_blocks do |t|
      t.references :placeable, polymorphic: true, null: false
      t.references :snippet, null: false, foreign_key: true
      t.integer :order_no, default: 0, null: false
      t.integer :hidden, default: 0, null: false
      t.timestamps
    end
  end
end
