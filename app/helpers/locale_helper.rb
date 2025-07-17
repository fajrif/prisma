module LocaleHelper

	def get_locale_current_page_route
		content_tag(:ul, class: "dropdown-menu") do
			path = request.path
			if path == "/cn"
				en_path = "/"
				cn_path = "/cn"
			else
				en_path = url_for(locale: nil)
				cn_path = url_for(locale: :cn)
			end

			content_tag(:li) do
				content_tag(:a, href: en_path) do
					content_tag(:i, nil, class: "icon-country usa") + "English"
				end
			end +
			content_tag(:li) do
				content_tag(:a, href: cn_path) do
					content_tag(:i, nil, class: "icon-country china") + "Chinese"
				end
			end

		end
	end

end
