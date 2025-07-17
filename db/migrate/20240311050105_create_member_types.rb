class CreateMemberTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :member_types do |t|
      t.jsonb :name, default: {}
    end
  end
end
