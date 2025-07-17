class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.string :title, null: false, default: ""
      t.string :slug, null: false, default: ""
			t.datetime :published_date
			t.integer :status, null: false, default: 1
			t.references :banner_section
      t.timestamps null: false
    end
    add_index :pages, :title, unique: true
    add_index :pages, :slug, unique: true
  end
end
