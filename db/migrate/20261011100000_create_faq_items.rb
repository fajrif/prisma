# Butir tanya-jawab untuk blok FAQ (T8). Blok FAQ sendiri adalah Snippet dengan template `faq`,
# jadi bisa dipasang lewat Sections/Segments/ContentBlocks seperti blok lain.
# question/answer jsonb per bahasa (Mobility); answer berisi HTML dari TinyMCE.
class CreateFaqItems < ActiveRecord::Migration[7.1]
  def change
    create_table :faq_items do |t|
      t.references :snippet, null: false, foreign_key: true
      t.jsonb :question, default: {}
      t.jsonb :answer, default: {}
      t.integer :order_no, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
