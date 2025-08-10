class CreatePortfolios < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolios do |t|
      t.jsonb :name, default: {}
      t.string :company_name, null: false, default: ""
      t.jsonb :description, default: {}
      t.integer :featured, null: false, default: 0
      t.timestamps
    end
    add_index :portfolios, :name, unique: true
  end
end
