class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
			t.string :name, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :phone, null: false, default: ""
      t.belongs_to :career
      t.timestamps null: false
    end
  end
end
