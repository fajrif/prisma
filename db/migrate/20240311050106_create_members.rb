class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.integer :order_no, null: false, default: 0
      t.string :full_name, null: false, default: ""
      t.jsonb :job_title, default: {}
      t.jsonb :description, default: {}
			t.references :member_type
      t.timestamps null: false
    end
  end
end
