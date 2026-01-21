class CreateInnovations < ActiveRecord::Migration[7.1]
  def change
    create_table :innovations do |t|
      t.jsonb :title, default: {}
      t.jsonb :description, default: {}
      t.string :icon
      t.string :link
      t.timestamps null: false
    end
  end
end
