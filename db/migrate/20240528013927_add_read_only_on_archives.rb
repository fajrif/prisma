class AddReadOnlyOnArchives < ActiveRecord::Migration[7.1]
  def change
		add_column :archives, :read_only, :integer, default: 0
		add_column :reports, :read_only, :integer, default: 0
  end
end
