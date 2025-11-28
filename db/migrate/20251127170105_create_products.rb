class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ""
      t.jsonb :description, default: {}
      t.string :specification, null: false, default: ""
      t.string :est_impression, null: false, default: ""
      t.string :longitude, null: false, default: ""
      t.string :latitude, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :interest, null: false, default: ""
      t.integer :location_id
      t.integer :product_category_id
      t.string :video_url, null: false, default: ""
      t.timestamps
    end
    add_index :products, :name, unique: true
		add_column :products, :slug, :string, default: ""
    add_index :products, :slug, unique: true
  end
end
