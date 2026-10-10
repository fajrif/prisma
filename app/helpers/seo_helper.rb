module SeoHelper

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

  # Title, description, robots, og:* dan gambar share halaman ini. Rantai fallback-nya
  # ada di SeoMeta.
  def seo_meta
    @seo_meta ||= SeoMeta.new(
      record: schema_subject,
      controller: controller_name,
      action: action_name
    )
  end

  # Gambar share; logo bila record tidak punya gambar.
  def seo_image_url
    seo_meta.image_url || image_url('logo-prisma.png?v=2')
  end

  # Generate canonical URL for the current page
  # - Always uses https://prisma-ads.com (no www)
  # - Strips trailing slashes for consistency
  # - Halaman berpaginasi memakai canonical ke dirinya sendiri (self-referencing)
  # - canonical_override dari panel SEO & Social menggantikan semuanya (sudah divalidasi
  #   di SeoMeta: hanya path internal atau host kanonik)
  def canonical_url
    return seo_meta.canonical_override if seo_meta.canonical_override.present?

    # Artikel dibuka di bahasa yang tidak punya isinya sendiri (hanya fallback en<->id):
    # canonical ke versi bahasa aslinya supaya tidak dihitung duplikat.
    return alternate_language_urls[article_canonical_locale] if article_canonical_locale

    url = "#{configatron.site_url}#{canonical_path}"
    page = params[:page].to_i
    page > 1 ? "#{url}?page=#{page}" : url
  end

  # Bahasa yang punya isi sendiri untuk artikel yang sedang dibuka; nil di halaman lain
  # (semua bahasa dianggap ada). Aturannya di Article#own_locales, sama dengan sitemap.
  def article_own_locales
    return unless controller_name == 'articles' && action_name == 'show' && @article.is_a?(Article)

    @article_own_locales ||= @article.own_locales
  end

  # Locale tujuan canonical bila bahasa halaman ini bukan bahasa yang punya isi sendiri.
  # nil bila halaman ini sendiri sudah benar (atau tidak ada data bahasa sama sekali).
  def article_canonical_locale
    locales = article_own_locales
    return if locales.blank? || locales.include?(I18n.locale.to_sym)

    locales.include?(:id) ? :id : locales.first
  end

  # Generate alternate language links for hreflang tags
  def alternate_language_urls
    stripped_path = canonical_path.sub(%r{\A/(id|cn)}, '')
    stripped_path = '/' if stripped_path.blank?

    # For root path, locale homepages have no suffix (avoids trailing-slash mismatch with canonical)
    path_suffix = stripped_path == '/' ? '' : stripped_path

    {
      en: "#{configatron.site_url}#{stripped_path}",
      id: "#{configatron.site_url}/id#{path_suffix}",
      cn: "#{configatron.site_url}/cn#{path_suffix}"
    }
  end

  # Generate hreflang link tags (en + id + zh-Hans + x-default → English).
  # Artikel: hanya bahasa yang punya isi sendiri; x-default → en bila ada, kalau tidak id.
  def hreflang_tags
    urls = alternate_language_urls
    only = article_own_locales
    urls = urls.slice(*only) if only.present?
    default = urls[:en] || urls[:id] || urls.values.first

    tags = []
    tags << tag.link(rel: 'alternate', hreflang: 'en',      href: urls[:en]) if urls[:en]
    tags << tag.link(rel: 'alternate', hreflang: 'id',      href: urls[:id]) if urls[:id]
    tags << tag.link(rel: 'alternate', hreflang: 'zh-Hans', href: urls[:cn]) if urls[:cn]
    tags << tag.link(rel: 'alternate', hreflang: 'x-default', href: default)

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

    manual = SchemaMarkup.matching(record: schema_subject, path: canonical_path).filter_map(&:parsed_body)

    # FAQPage otomatis dari blok FAQ yang tampil; dilewati bila Schema Manager sudah memasang
    # FAQPage untuk halaman ini, supaya tidak ada dua FAQPage.
    faq_items = manual_schema_types(manual).include?('FAQPage') ? [] : rendered_faq_items

    payloads = StructuredData::Registry.for(
      record: schema_subject,
      path: canonical_path,
      url: canonical_url,
      trail: breadcrumb_trail,
      faq_items: faq_items
    )
    tags << json_ld_script('@context' => 'https://schema.org', '@graph' => payloads) if payloads.present?

    manual.each { |parsed| tags << json_ld_script(parsed) }

    safe_join(tags, "\n\t")
  rescue StandardError => e
    Rails.logger.error("[StructuredData] render failed: #{e.class} #{e.message}")
    nil
  end

  # Semua @type di schema manual (termasuk yang ada di dalam @graph).
  def manual_schema_types(payloads)
    payloads.flat_map do |payload|
      nodes = payload.is_a?(Hash) && payload['@graph'].is_a?(Array) ? payload['@graph'] : Array.wrap(payload)
      nodes.flat_map { |node| node.is_a?(Hash) ? Array.wrap(node['@type']) : [] }
    end
  end

  def json_ld_script(payload)
    content_tag(:script, raw(json_escape(payload.to_json)), type: 'application/ld+json')
  end

  # Jejak navigasi halaman saat ini: [[nama, path], ...]
  # Dipakai untuk schema BreadcrumbList (tampilan visual menyusul Bulan 3).
  def breadcrumb_trail
    trail = [[t('breadcrumb.home'), locale_prefix.presence || '/']]

    case controller_name
    when 'pages'
      trail << [page_display_title(@page), canonical_path] if @page && canonical_path != (locale_prefix.presence || '/')
    when 'articles'
      trail << [t('breadcrumb.blog'), "#{locale_prefix}/articles"]
      trail << [@article.title, canonical_path] if @article
    when 'services'
      trail << [t('breadcrumb.services'), "#{locale_prefix}/services"]
      trail << [@service.name, canonical_path] if @service
    when 'industries'
      trail << [t('breadcrumb.industries'), "#{locale_prefix}/industries"]
      trail << [@industry.name, canonical_path] if @industry
    when 'portfolios'
      trail << [t('breadcrumb.campaigns'), "#{locale_prefix}/campaigns"]
      trail << [@portfolio.name, canonical_path] if @portfolio
    when 'locations'
      trail << [t('breadcrumb.locations'), "#{locale_prefix}/locations"]
      trail << [@location.name, canonical_path] if @location
    when 'products'
      if @product
        trail << [t('breadcrumb.locations'), "#{locale_prefix}/locations"]
        if @product.location
          trail << [@product.location.name, "#{locale_prefix}/locations/#{@product.location.slug}"]
        end
        trail << [@product.name, canonical_path]
      end
    when 'careers'
      trail << [t('breadcrumb.careers'), "#{locale_prefix}/careers"]
      trail << [@career.title, canonical_path] if @career
    when 'inquiries'
      trail << [t('breadcrumb.contact'), canonical_path]
    end

    trail
  end

  # Tanggal yang terbaca mesin: <time datetime="2026-10-09T10:00:00+07:00">Oct 09, 2026</time>.
  # Format tampilan dipertahankan sama dengan sebelumnya ('%b %d, %Y').
  def content_date_tag(time, format: '%b %d, %Y')
    return if time.blank?

    local = time.in_time_zone('Asia/Jakarta')
    content_tag(:time, local.strftime(format), datetime: local.iso8601)
  end

  # Label "Diperbarui" hanya bila admin mengisi modified_date minimal sehari setelah terbit.
  # Simpan ulang biasa (updated_at) tidak pernah memunculkannya.
  def updated_after_publish?(record)
    published = record.try(:published_date)
    modified = record.try(:modified_date)
    return false if published.blank? || modified.blank?

    (modified.to_date - published.to_date) >= 1
  end

  # Judul Page untuk tampilan publik. pages.title bukan Mobility, jadi halaman legal mengambil terjemahannya
  # dari `page_titles.<slug>` (config/locales); halaman lain jatuh ke pages.title seperti sebelumnya.
  def page_display_title(page)
    I18n.t("page_titles.#{page.slug}", default: page.title)
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
    elsif seo_meta.title.present?
      content_tag(:h1, seo_meta.title, class: 'visually-hidden seo-h1')
    end
  end

  # Isi editor (artikel/page) tidak boleh menambah H1 kedua; H1 halaman sudah ada di banner.
  # Diturunkan saat render saja, data di database tidak diubah.
  def demote_h1(content)
    content.to_s.gsub(/<(\/?)h1(?=[\s>])/i, '<\\1h2')
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
