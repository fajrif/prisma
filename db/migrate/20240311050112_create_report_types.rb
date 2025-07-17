class CreateReportTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :report_types do |t|
      t.jsonb :name, default: {}
    end
  end
end
