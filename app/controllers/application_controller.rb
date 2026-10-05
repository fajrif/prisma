class ApplicationController < ActionController::Base
	before_action :set_default_navbar_color

  protect_from_forgery

	layout :layout_by_resource

	include Locale

	helper_method :schema_subject

  protected

	# Record yang menjadi subjek schema otomatis pada halaman ini.
	# Diisi oleh controller publik pada action #show.
	def schema_subject
		@schema_subject
	end

  def layout_by_resource
		if controller_path.include? "admin"
			if devise_controller?
				"login"
			else
				"admin"
			end
    else
      "application"
    end
  end

	# Since the banner style using two colors
	# we need to set default color on Instance Variable
	def set_default_navbar_color
		@banner_text_color = "text-white-2"
		@nav_link_color = "white-link"
		@banner_btn_color = "btn-transparent-prisma"
	end

	def current_banner_section_style(banner_section)
		if banner_section
			unless banner_section.is_dark_theme?
				@banner_text_color = ""
				@nav_link_color = ""
				@banner_btn_color = "btn-prisma"
			end
		end
	end

end
