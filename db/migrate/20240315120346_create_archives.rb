class CreateArchives < ActiveRecord::Migration[7.1]
  def change
    create_table :archives do |t|
      t.jsonb :title, default: {}
      t.jsonb :short_description, default: {}
      t.string :category_name, null: false, default: ""
			t.references :archive_type
			t.datetime :published_date
			t.integer :status, null: false, default: 1
      t.timestamps null: false
    end
    add_index :archives, :title, unique: true
  end
end
