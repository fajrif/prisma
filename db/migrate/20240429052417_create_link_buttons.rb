class CreateLinkButtons < ActiveRecord::Migration[7.1]
  def change
    create_table :link_buttons do |t|
			t.references :linkable, polymorphic: true, null: false
			t.references :objectable, polymorphic: true, null: true
      t.integer :route_category, null: false, default: 0
      t.string :link_text, null: false, default: ""
      t.string :link_url, null: false, default: ""
      t.string :anchor, null: false, default: ""
      t.integer :open_new_tab, null: false, default: 0
    end
  end
end
