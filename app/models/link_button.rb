class LinkButton < ApplicationRecord

	default_scope { order(id: :asc) }

	belongs_to :linkable, polymorphic: true
	belongs_to :objectable, polymorphic: true, optional: true

	def is_open_new_tab?
		self.open_new_tab == 1
	end

	def open_new_tab_label
		self.is_open_new_tab? ? "true" : "false"
	end

	def route_category_label
		case self.route_category
		when 1
			"link-url"
		when 2
			"object"
		else
			"-"
		end
	end

	def is_link_route?
		self.route_category == 1
	end

	def is_object_route?
		self.route_category == 2
	end

	def is_app_route?
		self.route_category == 3
	end

	def is_route_to_file?
		self.objectable_type == "Archive" ||
		self.objectable_type == "Report"
	end

end
