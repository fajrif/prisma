class CreateGalleries < ActiveRecord::Migration[7.1]
  def change
    create_table :galleries do |t|
      t.jsonb :title, default: {}
			t.jsonb :caption, default: {}
			t.string :video_url, null: false, default: ""
      t.timestamps
    end
  end
end
