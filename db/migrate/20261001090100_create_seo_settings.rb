class CreateSeoSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :seo_settings do |t|
      t.string :seoable_type, null: false
      t.bigint :seoable_id, null: false
      t.jsonb :meta_title, default: {}
      t.jsonb :meta_description, default: {}
      t.jsonb :og_title, default: {}
      t.jsonb :og_description, default: {}
      t.string :og_type, default: "", null: false
      t.string :twitter_card, default: "", null: false
      t.string :canonical_override, default: "", null: false
      t.string :robots, default: "", null: false
      t.datetime :content_modified_at
      t.timestamps null: false
    end

    add_index :seo_settings, %i[seoable_type seoable_id], unique: true
  end
end
