class CreatePixServices < ActiveRecord::Migration[7.1]
  def change
    create_table :pix_services do |t|
      t.jsonb :title, default: {}
      t.jsonb :description, default: {}
      t.timestamps null: false
    end
  end
end
