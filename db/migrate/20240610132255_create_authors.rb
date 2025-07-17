class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
			t.string :name, null: false, default: ""
			t.string :title, null: false, default: ""
			t.string :company_name, null: false, default: ""
			t.string :phone, null: false, default: ""
			t.string :email, null: false, default: ""
      t.timestamps null: false
    end
  end
end
