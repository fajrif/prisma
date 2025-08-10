class AddColumnsToMain < ActiveRecord::Migration[7.1]
  def change
		add_column :services, :slug, :string, default: ""
    add_index :services, :slug, unique: true
		add_column :industries, :slug, :string, default: ""
    add_index :industries, :slug, unique: true
		add_column :services, :banner_section_id, :integer
		add_column :industries, :banner_section_id, :integer
  end
end
