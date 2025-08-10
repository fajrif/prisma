class CreateBenefits < ActiveRecord::Migration[7.1]
  def change
    create_table :benefits do |t|
			t.references :service
      t.jsonb :content, default: {}
    end
  end
end
