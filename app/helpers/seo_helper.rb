module SeoHelper
  # Generate canonical URL for the current page
  # - Always uses https://prisma-ads.com (no www)
  # - Strips trailing slashes for consistency
  # - Handles locale prefixes appropriately
  def canonical_url
    # Build the canonical URL
    base_url = "https://prisma-ads.com"
    
    # Get the current path
    path = request.path
    
    # Remove trailing slash if present (except for root)
    path = path.chomp('/') unless path == '/'
    
    # Handle pagination - remove page params from canonical
    # but keep the base URL
    if params[:page].present? && params[:page].to_i > 1
      # For paginated pages, include page in canonical
      "#{base_url}#{path}"
    else
      # For first page or non-paginated, use base path
      "#{base_url}#{path}"
    end
  end

  # Generate alternate language links for hreflang tags
  def alternate_language_urls
    base_url = "https://prisma-ads.com"
    current_path = request.path.chomp('/')
    
    # Check if we're on an Indonesian locale path
    if current_path.start_with?('/id')
      english_path = current_path.sub(/^\/id/, '')
      english_path = '/' if english_path.blank?
      
      {
        en: "#{base_url}#{english_path}",
        id: "#{base_url}#{current_path}"
      }
    else
      {
        en: "#{base_url}#{current_path.presence || '/'}",
        id: "#{base_url}/id#{current_path}"
      }
    end
  end

  # Generate hreflang link tags
  def hreflang_tags
    urls = alternate_language_urls
    
    tags = []
    tags << tag.link(rel: 'alternate', hreflang: 'en', href: urls[:en])
    tags << tag.link(rel: 'alternate', hreflang: 'id', href: urls[:id])
    tags << tag.link(rel: 'alternate', hreflang: 'x-default', href: urls[:en])
    
    safe_join(tags, "\n\t")
  end

  # Set the page H1 for SEO
  # Call this in your view: <% seo_h1("Page Heading") %>
  # The H1 will be rendered in the layout as a visually hidden element 
  # if no banner with H1 is present
  def seo_h1(heading_text)
    content_for(:seo_h1, heading_text)
  end

  # Render the SEO H1 tag if set and not already present in page content
  # This provides a fallback H1 that's visually hidden but accessible to search engines
  def render_seo_h1_fallback
    if content_for?(:seo_h1)
      content_tag(:h1, content_for(:seo_h1), class: 'visually-hidden seo-h1')
    elsif @meta_title.present?
      # Fallback to meta title if no explicit H1 is set
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
    return fallback || "Image" unless attachment.present?
    
    filename = attachment.filename.to_s.sub(/\.[^.]+$/, '')
    filename.titleize.gsub(/[-_]/, ' ').presence || fallback || "Image"
  end
end

