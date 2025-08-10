class CreateTestimonials < ActiveRecord::Migration[7.1]
  def change
    create_table :testimonials do |t|
			t.string :name, null: false, default: ""
      t.string :title, null: false, default: ""
			t.string :company_name, null: false, default: ""
      t.jsonb :message, default: {}
      t.timestamps null: false
    end
  end
end
