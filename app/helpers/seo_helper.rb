module SeoHelper
  BASE_URL = 'https://prisma-ads.com'.freeze

  # Maps Rails locale symbol to a valid BCP 47 language tag for <html lang>
  def html_lang_code
    case I18n.locale.to_sym
    when :cn then 'zh-Hans'
    when :id then 'id'
    else 'en'
    end
  end

  # Prefix locale untuk membangun URL internal ("" untuk :en)
  def locale_prefix
    I18n.locale.to_sym == I18n.default_locale.to_sym ? '' : "/#{I18n.locale}"
  end

  # Path halaman saat ini setelah dinormalisasi:
  # - tanpa trailing slash
  # - "/home" dan "/id/home" dianggap sama dengan halaman depan
  def canonical_path
    path = request.path
    path = path.chomp('/') unless path == '/'
    path = path.sub(%r{\A(/(?:id|cn))?/home\z}) { Regexp.last_match(1).to_s }
    path.presence || '/'
  end

  # Generate canonical URL for the current page
  # - Always uses https://prisma-ads.com (no www)
  # - Strips trailing slashes for consistency
  # - Halaman berpaginasi memakai canonical ke dirinya sendiri (self-referencing)
  def canonical_url
    url = "#{BASE_URL}#{canonical_path}"
    page = params[:page].to_i
    page > 1 ? "#{url}?page=#{page}" : url
  end

  # Generate alternate language links for hreflang tags
  def alternate_language_urls
    stripped_path = canonical_path.sub(%r{\A/(id|cn)}, '')
    stripped_path = '/' if stripped_path.blank?

    # For root path, locale homepages have no suffix (avoids trailing-slash mismatch with canonical)
    path_suffix = stripped_path == '/' ? '' : stripped_path

    {
      en: "#{BASE_URL}#{stripped_path}",
      id: "#{BASE_URL}/id#{path_suffix}",
      cn: "#{BASE_URL}/cn#{path_suffix}"
    }
  end

  # Generate hreflang link tags (en + id + zh-Hans + x-default → English)
  def hreflang_tags
    urls = alternate_language_urls

    tags = []
    tags << tag.link(rel: 'alternate', hreflang: 'en',        href: urls[:en])
    tags << tag.link(rel: 'alternate', hreflang: 'id',        href: urls[:id])
    tags << tag.link(rel: 'alternate', hreflang: 'zh-Hans',   href: urls[:cn])
    tags << tag.link(rel: 'alternate', hreflang: 'x-default', href: urls[:en])

    safe_join(tags, "\n\t")
  end

  # ---------------------------------------------------------------------------
  # Structured data (JSON-LD)
  # ---------------------------------------------------------------------------

  # Merender schema otomatis (satu blok @graph) + schema manual dari Schema Manager
  # (satu blok per entri). Dipanggil dari layout pada bagian <head>.
  def render_structured_data
    return if controller_name == 'errors'

    tags = []

    payloads = StructuredData::Registry.for(
      record: schema_subject,
      path: canonical_path,
      url: canonical_url,
      trail: breadcrumb_trail
    )
    tags << json_ld_script('@context' => 'https://schema.org', '@graph' => payloads) if payloads.present?

    SchemaMarkup.matching(record: schema_subject, path: canonical_path).each do |markup|
      parsed = markup.parsed_body
      tags << json_ld_script(parsed) if parsed.present?
    end

    safe_join(tags, "\n\t")
  rescue StandardError => e
    Rails.logger.error("[StructuredData] render failed: #{e.class} #{e.message}")
    nil
  end

  def json_ld_script(payload)
    content_tag(:script, raw(json_escape(payload.to_json)), type: 'application/ld+json')
  end

  # Jejak navigasi halaman saat ini: [[nama, path], ...]
  # Dipakai untuk schema BreadcrumbList (tampilan visual menyusul Bulan 3).
  def breadcrumb_trail
    trail = [['Home', locale_prefix.presence || '/']]

    case controller_name
    when 'pages'
      trail << [@page.title, canonical_path] if @page && canonical_path != (locale_prefix.presence || '/')
    when 'articles'
      trail << ['Blog', "#{locale_prefix}/articles"]
      trail << [@article.title, canonical_path] if @article
    when 'services'
      trail << ['Services', "#{locale_prefix}/services"]
      trail << [@service.name, canonical_path] if @service
    when 'industries'
      trail << ['Industries', "#{locale_prefix}/industries"]
      trail << [@industry.name, canonical_path] if @industry
    when 'portfolios'
      trail << ['Campaigns', "#{locale_prefix}/campaigns"]
      trail << [@portfolio.name, canonical_path] if @portfolio
    when 'locations'
      trail << ['Locations', "#{locale_prefix}/locations"]
      trail << [@location.name, canonical_path] if @location
    when 'products'
      if @product
        trail << ['Locations', "#{locale_prefix}/locations"]
        trail << [@product.location.name, "#{locale_prefix}/locations/#{@product.location.slug}"] if @product.location
        trail << [@product.name, canonical_path]
      end
    when 'careers'
      trail << ['Careers', "#{locale_prefix}/careers"]
      trail << [@career.title, canonical_path] if @career
    when 'inquiries'
      trail << ['Contact Us', canonical_path]
    end

    trail
  end

  # Set the page H1 for SEO
  # Call this in your view: <% seo_h1("Page Heading") %>
  # The H1 will be rendered in the layout as a visually hidden element
  # if no banner with H1 is present
  def seo_h1(heading_text)
    content_for(:seo_h1, heading_text)
  end

  # Render the SEO H1 tag if no visible H1 already exists in the page content.
  # Banner/snippet partials set content_for(:has_visible_h1) when they render an <h1>.
  def render_seo_h1_fallback
    return if content_for?(:has_visible_h1)

    if content_for?(:seo_h1)
      content_tag(:h1, content_for(:seo_h1), class: 'visually-hidden seo-h1')
    elsif @meta_title.present?
      content_tag(:h1, @meta_title, class: 'visually-hidden seo-h1')
    end
  end

  # Helper to generate images with automatic alt text from filename
  # Usage: <%= seo_image_tag(image, alt: "Custom alt text") %>
  # or: <%= seo_image_tag(image) %> to auto-generate from filename
  def seo_image_tag(source, options = {})
    # If no alt provided, generate from filename
    unless options[:alt].present?
      filename = source.is_a?(String) ? File.basename(source, '.*') : source.try(:filename).to_s.sub(/\.[^.]+$/, '')
      options[:alt] = filename.to_s.titleize.gsub(/[-_]/, ' ')
    end

    image_tag(source, options)
  end

  # Helper to generate alt text from Active Storage attachment
  def attachment_alt_text(attachment, fallback = nil)
    return fallback || 'Image' unless attachment.present?

    filename = attachment.filename.to_s.sub(/\.[^.]+$/, '')
    filename.titleize.gsub(/[-_]/, ' ').presence || fallback || 'Image'
  end
end
