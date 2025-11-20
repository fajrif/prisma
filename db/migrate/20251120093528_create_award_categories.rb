class CreateAwardCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :award_categories do |t|
			t.string :name, null: false, default: ""
			t.string :description, null: false, default: ""
    end

    # add belongs_to column
    add_column :awards, :award_category_id, :integer
  end
end
