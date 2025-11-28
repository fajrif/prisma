class CreateProductCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :product_categories do |t|
      t.string :name, null: false, default: ""
      t.timestamps null: false
    end
  end
end
