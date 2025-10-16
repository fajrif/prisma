class CreateAwards < ActiveRecord::Migration[7.1]
  def change
    create_table :awards do |t|
      t.jsonb :name, default: {}
      t.jsonb :description, default: {}
      t.timestamps null: false
    end
  end
end
