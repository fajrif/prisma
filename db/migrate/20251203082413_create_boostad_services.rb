class CreateBoostadServices < ActiveRecord::Migration[7.1]
  def change
    create_table :boostad_services do |t|
      t.jsonb :title, default: {}
      t.jsonb :description, default: {}
      t.timestamps
    end
  end
end
