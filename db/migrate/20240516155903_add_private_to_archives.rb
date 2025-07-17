class AddPrivateToArchives < ActiveRecord::Migration[7.1]
  def change
		add_column :archives, :private, :integer, default: 0
		add_column :reports, :private, :integer, default: 0
  end
end
