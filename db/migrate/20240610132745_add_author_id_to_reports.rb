class AddAuthorIdToReports < ActiveRecord::Migration[7.1]
  def change
		add_reference :reports, :author
  end
end
