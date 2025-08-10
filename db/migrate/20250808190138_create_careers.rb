class CreateCareers < ActiveRecord::Migration[7.1]
  def change
    create_table :careers do |t|
      t.string :title, null: false, default: ""
      t.jsonb :short_description, default: {}
      t.string :location, null: false, default: ""
			t.string :company_name, null: false, default: ""
			t.datetime :published_date
      t.integer :status, null: false, default: 1
      t.timestamps null: false
    end
		add_column :careers, :slug, :string, default: ""
    add_index :careers, :slug, unique: true
  end
end
