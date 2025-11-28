class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false, default: ""
      t.jsonb :description, default: {}
      t.timestamps null: false
    end
    add_index :locations, :name, unique: true
		add_column :locations, :slug, :string, default: ""
    add_index :locations, :slug, unique: true
  end
end
