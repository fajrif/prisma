class AddBannerSectionToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :banner_section_id, :integer
  end
end
