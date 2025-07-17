class Menu < ApplicationRecord
	extend Mobility
  translates :data

	validates_presence_of :data, :section
	validates_uniqueness_of :section

	def header?
		self.section == 1
	end

	def footer?
		self.section == 2
	end

	def section_label
		if self.header?
			"Header"
		elsif self.footer?
			"Footer"
		end
	end

	def data_label
		self.data.blank? ? {} : "JSON data"
	end

end
