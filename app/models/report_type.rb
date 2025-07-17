class ReportType < ApplicationRecord
	extend Mobility
  translates :name

	default_scope { order(id: :asc) }

	validates_presence_of :name
	validates_uniqueness_of :name

	has_many :reports

end
