class AddParentToSnippets < ActiveRecord::Migration[7.1]
  def change
		add_column :snippets, :parent_id, :integer
  end
end
