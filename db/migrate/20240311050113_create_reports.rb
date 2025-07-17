class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.jsonb :title, default: {}
      t.jsonb :short_description, default: {}
			t.references :report_type
			t.datetime :published_date
			t.integer :status, null: false, default: 1
      t.timestamps null: false
    end
    add_index :reports, :title, unique: true
  end
end
