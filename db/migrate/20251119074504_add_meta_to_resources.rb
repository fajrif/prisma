class AddMetaToResources < ActiveRecord::Migration[7.1]
  def change
		add_column :services, :meta_title, :jsonb, default: {}
		add_column :services, :meta_description, :jsonb, default: {}
		add_column :industries, :meta_title, :jsonb, default: {}
		add_column :industries, :meta_description, :jsonb, default: {}
		add_column :portfolios, :meta_title, :jsonb, default: {}
		add_column :portfolios, :meta_description, :jsonb, default: {}
  end
end
