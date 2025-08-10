class CreateSegments < ActiveRecord::Migration[7.1]
  def change
    create_table :segments do |t|
			t.references :service
			t.references :snippet
			t.string :bg_color, null: false, default: ""
			t.string :css_class, null: false, default: ""
      t.integer :order_no, null: false, default: 0
      t.integer :hidden, null: false, default: 0
    end
  end
end
