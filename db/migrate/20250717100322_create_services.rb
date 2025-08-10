class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.jsonb :name, default: {}
      t.jsonb :caption, default: {}
      t.jsonb :short_description, default: {}
      t.jsonb :description, default: {}
      t.jsonb :benefit_title, default: {}
      t.jsonb :benefit_description, default: {}
			t.string :color, null: false, default: ""
      t.timestamps null: false
    end
  end
end
