class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
			t.string :company_name, null: false, default: ""
      t.string :link, null: false, default: ""
      t.timestamps null: false
    end
  end
end
