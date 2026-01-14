class AddBillboardTypeToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :billboard_type, :integer, default: 0, null: false
  end
end
