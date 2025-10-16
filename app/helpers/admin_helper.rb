module AdminHelper

  def blank_or_not(object,blank='-')
    if object.blank?
      blank
    else
      if block_given?
        yield
      else
        object
      end
    end
  end

	def flash_message
    message = ""
    flash.each do |name, msg|
			message += content_tag :div, :class => "alert alert-#{name.to_sym == :notice ? 'success' : 'danger'} alert-dismissible alert-label-icon label-arrow fade show" do
				lbl = if name.to_sym == :notice
					content_tag(:i, nil, class: "ri-notification-off-line label-icon") + content_tag(:strong, "Success")
				else
					content_tag(:i, nil, class: "ri-error-warning-line label-icon") + content_tag(:strong, "Danger")
				end
				lbl += " - #{msg}"
				lbl += content_tag(:button, nil, class: "btn-close", "data-bs-dismiss": "alert", "aria-label": "Close")
			end unless msg == true
    end
    message.html_safe
  end

	def flash_message2
    message = ""
    flash.each do |name, msg|
			message += content_tag :div, :class => "alert alert-#{name.to_sym == :notice ? 'success' : 'danger'} alert-dismissible alert-label-icon label-arrow fade show" do
				lbl = raw(msg)
				lbl += content_tag(:button, nil, class: "btn-close", "data-bs-dismiss": "alert", "aria-label": "Close") do
					content_tag(:i, nil, class: "fa-solid fa-close text-white-2")
				end
			end unless msg == true
    end
		flash.discard
    message.html_safe
  end

	def get_input_date_value(field, format='%d/%m/%Y %H:%M')
		field.nil? ? '' : field.strftime(format)
	end

	def sortable(column, title = nil)
    title ||= column
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_tag = link_to title.titleize, params.merge(:sort => column, :direction => direction, :page => nil)
    icon_tag = column == params[:sort] ? "&nbsp;<i class='#{direction == "asc" ? "icon-arrow-up" : "icon-arrow-down"}'></i>" : ""
    link_tag + icon_tag.html_safe
  end

	def empty_data_message(model, new_link)
		raw("Currently there are no data #{model.model_name.human.pluralize.downcase} at the moment. Please create one by clicking #{link_to "here", new_link}.")
	end

	def title_page(page_title)
    content_for(:title) do
			content_tag(:div, :class => "row") do
				content_tag(:div, :class => "col-12") do
					content_tag(:div, :class => "page-title-box d-sm-flex align-items-center justify-content-between") do
						content_tag(:h4, page_title, :class => "mb-sm-0")
					end
				end
			end
		end
  end

	def current_path?(*path)
		re = Regexp.union(path)
		return 'active' if request.path.match(re)
		''
  end

	def get_link_button_objects
		["Page", "Article", "Archive", "Report"]
	end

	def get_link_button_route_categories
		[[0, "none"], [1, "link-url"], [2, "object"]]
	end

	def available_snippets_template
		[
			"row_cols",
			"row_cols_holder",
			"row_cols_bgimage",
			"tabs",
			"tabs_section",
			"tab_pane",
			"grid_column",
			"col_info",
			"col_bgimage",
			"call_to_action1",
			"call_to_action2",
			"call_to_action3",
			"image_display",
			"display_image",
			"video_display",
			"video_popup",
			"info_image",
			"info_image2",
			"info_image_left",
			"info_text_box",
      "our_clients",
      "service_title",
      "info_bg",
      "info_desc_bg",
      "info_image_box",
      "info_image_box_2",
      "benefit_list",
			"info_description"
		]
	end

	def nested_snippets_template
		[ "row_cols", "row_cols_holder", "row_cols_bgimage", "grid_column", "tabs", "tabs_section", "tab_pane" ]
	end

	def available_snippets_orientations
		[
			"left",
			"center",
			"right",
			"full-width"
		]
	end

	def available_bg_colors
		[
			"bg-green",
			"bg-green-gradient",
			"bg-grey",
			"bg-dark-grey",
			"bg-very-dark-grey",
      "bg-gradient-purple",
			"bg-black",
			"bg-image"
		]
	end

	def available_text_colors
		[
			"text-dark-grey",
			"text-white-2"
		]
	end

	def get_banner_styles
		[['0', 'dark-theme'], ['1', 'light-theme']]
	end

	def get_banner_sizes
		[['0', 'large'], ['1', 'medium'], ['2', 'small']]
	end

	def get_published_status
		[[0, 'Draft'], [1, 'Published']]
	end

	def get_private_status
		[[0, 'Public'], [1, 'Private']]
	end

	def get_read_only_status
		[[0, 'Global'], [1, 'Read-Only']]
	end

	def has_asset?(path)
		(Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset(path) != nil
	end

	def replace_non_break(title)
		return title.gsub(/<br\/>/,' ')
	end

	# <span class="badge bg-primary">Primary</span>
	def badge_true_false_status(val, txt=nil)
		content_tag(:span, txt || val.to_s, class: "badge bg-#{val == 1 ? 'primary' : 'danger'}")
	end

	# <span class="badge bg-primary-subtle text-primary badge-border">Primary</span>
	def badge_route_category(route_category)
		case route_category
		when 1
			cls = "info"
			lbl = "link-route"
		when 2
			cls = "primary"
			lbl = "object"
		else
			return route_category
		end
		return content_tag(:span, lbl, class: "badge bg-#{cls}-subtle text-#{cls} badge-border")
	end

	# <span class="badge rounded-pill border border-primary text-primary">Primary</span>
	def badge_member_type(member_type)
		if member_type
			case member_type.id
			when 1
				cls = "secondary"
			when 2
				cls = "success"
			else
				cls = "dark"
			end
			return content_tag(:span, member_type.name, class: "badge rounded-pill border border-#{cls} text-#{cls} badge-border")
		end
	end

	# <span class="badge badge-label bg-primary"><i class="mdi mdi-circle-medium"></i> Primary</span>
	def badge_category(category)
		if category
			case category.id
			when 1
				cls = "primary"
			when 2
				cls = "secondary"
			when 3
				cls = "success"
			when 4
				cls = "danger"
			when 5
				cls = "warning"
			when 6
				cls = "info"
			when 7
				cls = "dark"
			when 8
				cls = "primary"
			when 9
				cls = "secondary"
			when 10
				cls = "success"
			when 11
				cls = "danger"
			when 12
				cls = "warning"
			when 13
				cls = "info"
			when 14
				cls = "dark"
			else
				cls = "light"
			end
			return content_tag(:span, class: "badge badge-label bg-#{cls}") do
				content_tag(:i, nil, class: "mdi mdi-circle-medium") + " #{category.name}"
			end
		end
	end

  def is_home_page?
    controller.controller_name == "pages" && (params[:id] == "home" || params[:id] == "id")
  end

  def is_about_page?
    controller.controller_name == "pages" && params[:id] == "about-us"
  end

  def is_services_page?
    controller.controller_name == "services"
  end

  def is_industries_page?
    controller.controller_name == "industries"
  end

  def is_blogs_page?
    controller.controller_name == "articles"
  end

  def is_careers_page?
    controller.controller_name == "careers"
  end

  def is_errors_page?
    controller.controller_name == "errors"
  end

  def is_contact_page?
		controller.controller_name == "inquiries" && controller.action_name == "show"
	end

  def is_dark_page?
    (controller.controller_name == "home" && controller.action_name == "index") ||
    (controller.controller_name == "articles" && controller.action_name == "show") ||
    controller.controller_name == "contacts"
  end

	def is_admins_dashboard_page?
		controller.controller_name == "dashboard"
	end

  def is_admins_articles_page?
		controller.controller_name == "articles" ||
		controller.controller_name == "categories"
  end

  def is_admins_content_page?
		controller.controller_name == "pages" ||
		controller.controller_name == "banner_sections" ||
		controller.controller_name == "banners" ||
		controller.controller_name == "snippets"
  end

  def is_admins_services_page?
		controller.controller_name == "services" ||
		controller.controller_name == "benefits" ||
		controller.controller_name == "industries" ||
		controller.controller_name == "portfolios"
  end

	def is_admins_others_page?
		controller.controller_name == "menus" ||
		controller.controller_name == "addresses" ||
		controller.controller_name == "clients" ||
		controller.controller_name == "testimonials" ||
		controller.controller_name == "awards" ||
		controller.controller_name == "careers"
	end

	def is_admins_users_page?
		controller.controller_name == "admins"
	end

  def is_admins_contact_page?
		controller.controller_name == "inquiries"
	end

end
