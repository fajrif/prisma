module LocaleHelper

	def get_locale_current_page_route
		content_tag(:div, class: "local-link", role: "group", "aria-label": I18n.t("global.language_switcher")) do
			path = request.path
			if path == "/id"
				en_path = "/"
				id_path = "/id"
				cn_path = "/cn"
			elsif path == "/cn"
				en_path = "/"
				id_path = "/id"
				cn_path = "/cn"
			else
				en_path = url_for(locale: nil)
				id_path = url_for(locale: :id)
				cn_path = url_for(locale: :cn)
			end

      content_tag(:a, href: en_path, hreflang: "en", lang: "en", "aria-label": "EN, English", "aria-current": (I18n.locale == :en ? "true" : nil), class: "#{ 'active' if I18n.locale == :en}") do
        "EN"
			end +
      content_tag(:a, href: id_path, hreflang: "id", lang: "id", "aria-label": "ID, Bahasa Indonesia", "aria-current": (I18n.locale == :id ? "true" : nil), class: "#{ 'active' if I18n.locale == :id}") do
        "ID"
      end +
      content_tag(:a, href: cn_path, hreflang: "zh-Hans", lang: "zh-Hans", "aria-label": "CN, 中文", "aria-current": (I18n.locale == :cn ? "true" : nil), class: "#{ 'active' if I18n.locale == :cn}") do
        "CN"
      end
		end
	end

end
