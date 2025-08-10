class CreateIndustries < ActiveRecord::Migration[7.1]
  def change
    create_table :industries do |t|
      t.jsonb :name, default: {}
      t.jsonb :caption, default: {}
      t.jsonb :description, default: {}
      t.timestamps null: false
    end
  end
end
