class AddCompanyProfileToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :legal_name, :string, default: "", null: false
    add_column :settings, :alternate_name, :string, default: "", null: false
    add_column :settings, :founding_date, :date
    add_column :settings, :email, :string, default: "", null: false
    add_column :settings, :phone, :string, default: "", null: false
    add_column :settings, :whatsapp, :string, default: "", null: false
    add_column :settings, :same_as, :jsonb, default: []
    add_column :settings, :description, :jsonb, default: {}
  end
end
