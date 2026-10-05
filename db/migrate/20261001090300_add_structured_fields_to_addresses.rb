class AddStructuredFieldsToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :street_address, :string, default: "", null: false
    add_column :addresses, :locality, :string, default: "", null: false
    add_column :addresses, :region, :string, default: "", null: false
    add_column :addresses, :postal_code, :string, default: "", null: false
    add_column :addresses, :country_code, :string, default: "ID", null: false
    add_column :addresses, :primary_office, :boolean, default: false, null: false
  end
end
