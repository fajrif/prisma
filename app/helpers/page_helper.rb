module PageHelper

	# Rendering Link to Url Helper
	def render_link_text_url(object, class_name="btn btn-medium btn-prisma btn-rounded", only_arrow=false)
		# check if object file downloadable
		if object.is_route_to_file?
			return render_link_file_url(object, class_name)
		else
			_target = object.is_open_new_tab? ? :_blank : :_self
			_text = object.link_text
			_text = get_text_from_object(_text, object)
			_text = t("global.read_more") if _text.blank?
      _content_with_icon = _text
			link_to(get_link_from_link_button_object(object), class: class_name, target: _target) do
				_content_with_icon
			end
		end
	end

	# Rendering Link to File Helper (Downloadable Icon)
	def render_link_file_url(object, class_name="btn btn-medium btn-prisma btn-rounded")
		_text = object.link_text
		_text = get_text_from_object(_text, object)
		_text = t("global.download_now") if _text.blank?
		link_to(_text, get_link_from_link_button_object(object), class: class_name)
	end

	def get_text_from_object(text, object)
		_text = ""
		if text.include?("_")
			if text == "view_title"
				_text = object.try(:objectable).try(:title)
			else
				_text = t("global.#{object.link_text}")
			end
		else
			_text = text
		end
		return _text
	end

	def get_prisma_element_colors(bg_color)
	 if bg_color == 'bg-green' or bg_color == 'bg-black' or bg_color == "bg-dark-grey" or bg_color == "bg-green-gradient"
			return 'text-white-2', 'btn-transparent-prisma'
		elsif bg_color == 'bg-yellow' or bg_color == 'bg-grey'
			return 'text-extra-dark-gray', 'btn-prisma btn-border'
		else
			return 'text-extra-dark-gray', 'btn-prisma btn-border'
		end
	end

	def get_default_logo(class_logo)
		default_class = ""
		case class_logo
		when "logo-dark"
			default_class = "default" if @nav_link_color.empty?
		when "logo-light"
			default_class = "default" unless @nav_link_color.empty?
		end
		return "#{class_logo} #{default_class}".strip
	end

	# IF need to update recent file?
	#  some code need to be added
	def get_link_from_link_button_object(obj)
		case obj.route_category
		when 1
			obj.anchor.blank? ? obj.link_url : "#{obj.link_url}#{obj.anchor}"
		when 2
			case obj.objectable_type
			when "Page"
				"#{page_url(obj.objectable)}#{obj.anchor}"
			when "Article"
				article_path(obj.objectable)
			when "Report"
				request_downloadable_file(obj.objectable)
			when "Archive"
				request_downloadable_file(obj.objectable)
			end
		end
	rescue
		puts "Error get link from object"
		return ""
	end

	def request_downloadable_file(obj)
		if obj.private?
			document_inquiries_path(id: obj.id, type: obj.class.name.downcase)
		else
			# fallback to default :en file
			file = obj.file
			if obj.read_only?
				pdfjs.minimal_path(file: rails_storage_proxy_path(obj.file))
			else
				rails_blob_path(file, disposition: "attachment")
			end
		end
	end

	def render_link_download_file(object, class_name="btn btn-medium btn-prisma btn-rounded", text=t("global.download"))
		options = { class: class_name }
		if object.read_only?
			options[:target] = :_blank
			text = t('global.view')
		end
		link_to(text, request_downloadable_file(object), options)
	end

	def load_header_menu
		if data_menu = Menu.find_by(section: 1).try(:data)
			@header_menu = JSON.parse(data_menu)
		end
	end

	def load_footer_menu
		if data_menu = Menu.find_by(section: 2).try(:data)
			@footer_menu = JSON.parse(data_menu)
		end
	end

	def generate_dropdown_menu(data)
		_menu = ""
		if data
      _dropdown = ""
			data.each do |menu|
				if menu["menu"]
          _submenu = menu["label"] + content_tag(:i, nil, class: "fa-solid fa-angle-right")
          _dropdown += content_tag(:li, class: "dropdown") do
            link_to(menu["url"] ? menu["url"] : "#", class: "dropdown-toggle") do
              raw(_submenu)
            end + generate_dropdown_menu(menu["menu"])
          end
        else
          _dropdown += content_tag(:li) do
            link_to(menu["label"], menu["url"] ? menu["url"] : "#")
          end
        end
			end
      _menu = content_tag(:ul, class: "dropdown-menu", role: "menu") do
        raw(_dropdown)
      end
		end
		return _menu
	end

	def generate_navbar_menu(data)
		_menu = ""
		if data
			data.each do |menu|
        active_class = set_active_class_menu(menu["active_path"])
				if menu["menu"]
          _submenu = link_to(menu["label"], menu["url"] ? menu["url"] : "#", class: active_class) +
              content_tag(:i, nil, class: "fa-solid fa-angle-down dropdown-toggle") +
              generate_dropdown_menu(menu["menu"])
					_menu += content_tag(:li, class: "dropdown simple-dropdown") do
            raw(_submenu)
          end
				else
					_menu += content_tag(:li) do
						link_to(menu["label"], menu["url"] ? menu["url"] : "#", class: active_class)
					end
				end
			end
		end
		return _menu
	end

	def set_active_class_menu(path)
    active_class = ""
    active_class = "active" if is_home_page? && path == "home"
    active_class = "active" if is_about_page? && path == "about"
    active_class = "active" if is_services_page? && path == "services"
    active_class = "active" if is_industries_page? && path == "industries"
    active_class = "active" if is_blogs_page? && path == "articles"
    active_class = "active" if is_careers_page? && path == "careers"
    active_class = "active" if is_contact_page? && path == "contact-us"
    return active_class
  end

	def generate_footer_link(data)
		_menu = ""
		data.each do |menu|
			_menu += content_tag(:li, class: "margin-10px-bottom") do
				link_to(menu["label"], menu["url"] ? menu["url"] : "#", class: "text-white-2")
			end
		end
		return _menu
	end

	def generate_footer_contact_us(data)
		menu = data.last
		_menu = link_to(menu["url"] ? menu["url"] : "#") do
			content_tag(:h5, menu["label"], class: "text-uppercase mb-0")
		end
		return _menu
	end

	def generate_popup_menus(*data)
		_content = ""
		_menu = []
		data.compact!
		data.each do |d|
			_menu << d.select {|m| m["menu"] }
		end
		_menu.flatten!
		_menu.each do |menu|
			_list = ""
			menu["menu"].each do |cm|
				_list += content_tag(:li) do
					link_to(cm["label"], cm["url"], class: "inner-link")
				end
			end
			_content += content_tag(:div, id: "menu-content-#{menu['id']}", class: "menu-wrap-content-menu") do
				content_tag(:div) do
					if menu["url"]
						content_tag(:h5, nil, class: "font-weight-400 text-uppercase") do
							link_to(menu["label"], menu["url"])
						end
					else
						content_tag(:h5, menu["label"], class: "font-weight-400 text-uppercase")
					end
				end +
				content_tag(:ul, class: "font-weight-400 no-padding-left mb-0") do
					raw(_list)
				end
			end
		end
		return _content
	end

	def generate_popup_menus_mobile(*data)
		_content = ""
		_menu = []
		data.compact!
		data.each do |d|
			_menu << d
		end
		_menu.flatten!
		_menu.each do |menu|
			if menu["menu"]
				_list = ""
				menu["menu"].each do |cm|
					_list += content_tag(:li) do
						link_to(cm["label"], cm["url"], class: "inner-link")
					end
				end
				_dropdown_menu = content_tag(:ul, class: "dropdown-menu") do
					raw(_list)
				end
				_content += content_tag(:li, class: "dropdown") do
					link_to(menu["label"], menu["url"] ? menu["url"] : "#", class: "text-uppercase") + content_tag(:span, nil, class: "dropdown-toggle") + _dropdown_menu
				end
			else
				_content += content_tag(:li) do
					link_to(menu["label"], menu["url"] ? menu["url"] : "#", class: "text-uppercase")
				end
			end
		end
		return _content
	end

end
