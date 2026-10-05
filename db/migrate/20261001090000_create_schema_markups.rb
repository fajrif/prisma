class CreateSchemaMarkups < ActiveRecord::Migration[7.1]
  def change
    create_table :schema_markups do |t|
      t.string :name, default: "", null: false
      t.integer :scope_type, default: 0, null: false
      t.string :schemable_type
      t.bigint :schemable_id
      t.string :path_pattern, default: "", null: false
      t.string :schema_type, default: "", null: false
      t.jsonb :body, default: {}
      t.integer :status, default: 1, null: false
      t.integer :order_no, default: 0, null: false
      t.timestamps null: false
    end

    add_index :schema_markups, %i[schemable_type schemable_id]
    add_index :schema_markups, :path_pattern
    add_index :schema_markups, :status
  end
end
