class Admins::LinkButtonsController < Admins::BaseController

	def objectable_types
		type = params[:type] ? params[:type] : "Page"
		@objectables = type.blank? ? [] : type.constantize.all
	end

end
