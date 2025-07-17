class ArchiveType < ApplicationRecord
	extend Mobility
  translates :name

	default_scope { order(id: :asc) }

	validates_presence_of :name
	validates_uniqueness_of :name

	has_many :archives

	# ID: 1
	def self.get_latest_company_profile
		archive_type = ArchiveType.find_by_id(1)
		ArchiveType.get_archives(archive_type, limit)
	end

	# ID: 2
	def self.get_corporate_materials(limit=4)
		archive_type = ArchiveType.find_by_id(2)
		ArchiveType.get_archives(archive_type, limit)
	end

	def self.get_archives(type, limit)
		if type
			type.archives.where(status: 1).limit(limit)
		else
			[]
		end
	end
end
