class CreatePortfolios < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolios do |t|
      t.string :name, null: false, default: ""
      t.string :company_name, null: false, default: ""
      t.jsonb :caption, default: {}
      t.jsonb :short_description, default: {}
      t.jsonb :description, default: {}
      t.string :media_used, null: false, default: ""
      t.string :collaborators, null: false, default: ""
      t.integer :featured, null: false, default: 0
      t.integer :service_id
      t.integer :industry_id
      t.jsonb :about_campaign, default: {}
      t.jsonb :area_coverage, default: {}
      t.jsonb :creative_highlights, default: {}
      t.string :video_url, null: false, default: ""
      t.timestamps
    end
    add_index :portfolios, :name, unique: true
		add_column :portfolios, :slug, :string, default: ""
    add_index :portfolios, :slug, unique: true
  end
end
