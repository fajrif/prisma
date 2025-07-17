class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus do |t|
      t.integer :section, null: false, default: 0
      t.jsonb :data, default: {}
    end
  end
end
