module LocaleHelper

	def get_locale_current_page_route
		content_tag(:div, class: "local-link") do
			path = request.path
			if path == "/id"
				en_path = "/"
				id_path = "/id"
			else
				en_path = url_for(locale: nil)
				id_path = url_for(locale: :id)
			end

      content_tag(:a, href: en_path, class: "#{ 'active' if I18n.locale == :en}") do
        "EN"
			end +
      content_tag(:a, href: id_path, class: "#{ 'active' if I18n.locale == :id}") do
        "ID"
      end
		end
	end

end
