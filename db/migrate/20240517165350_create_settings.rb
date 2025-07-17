class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.string :admin_contact, null: false, default: ""
      t.timestamps null: false
    end
  end
end
