class CreateSnippets < ActiveRecord::Migration[7.1]
  def change
    create_table :snippets do |t|
      t.string :name, null: false, default: ""
      t.jsonb :title, default: {}
      t.jsonb :caption, default: {}
      t.jsonb :short_description, default: {}
      t.jsonb :description, default: {}
      t.string :title_tag, null: false, default: ""
      t.string :text_color, null: false, default: ""
      t.string :template, null: false, default: ""
      t.string :bg_color, null: false, default: ""
      t.string :css_class, null: false, default: ""
      t.string :css_title, null: false, default: ""
      t.string :css_desc, null: false, default: ""
			t.string :orientation
			t.string :video_url, null: false, default: ""
      t.timestamps null: false
    end
    add_index :snippets, :name, unique: true
  end
end
