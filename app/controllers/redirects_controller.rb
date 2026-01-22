class RedirectsController < ApplicationController
  # Handle legacy WordPress blog URLs: /YYYY/MM/DD/slug/
  def legacy_blog
    # Extract the slug from the path
    slug = extract_slug_from_path(params[:path])
    
    if slug.present?
      # Try to find matching article by slug
      article = Article.friendly.find_by(slug: normalize_slug(slug))
      
      if article
        redirect_to article_path(article), status: :moved_permanently
        return
      end
    end
    
    # If no matching article, redirect to articles index
    redirect_to articles_path, status: :moved_permanently
  end

  # Handle legacy /works/ URLs -> redirect to /campaigns/
  def legacy_works
    slug = params[:slug]
    
    if slug.present?
      # Try to find matching portfolio/campaign
      portfolio = Portfolio.friendly.find_by(slug: slug)
      
      if portfolio
        redirect_to portfolio_path(portfolio), status: :moved_permanently
        return
      end
    end
    
    redirect_to portfolios_path, status: :moved_permanently
  end

  # Handle legacy /wp-content/ URLs (old WordPress uploads) -> 410 Gone
  def legacy_wp_content
    head :gone
  end

  # Handle other legacy pages that should redirect to home or specific pages
  def legacy_page
    slug = params[:slug].to_s.downcase.gsub(/[-_]/, '')
    
    # Map legacy slugs to new locations
    redirect_map = {
      'metaled' => innovations_path,
      'perbedaanoohdooh' => about_us_path,
      '3inovasippalingdiminati' => innovations_path,
      '3lokasistrategisooh' => locations_path,
      'inovasikunciooh' => innovations_path,
      'bringrandeled' => page_path('home'),
      'ledtekukumar' => locations_path,
      'ledbraga' => locations_path
    }
    
    target = redirect_map[slug] || root_path
    redirect_to target, status: :moved_permanently
  end

  private

  def extract_slug_from_path(path)
    return nil if path.blank?
    
    # Path format: YYYY/MM/DD/slug or just slug
    # Remove date prefix if present and extract the last segment
    segments = path.to_s.split('/').reject(&:blank?)
    
    # If we have date segments (YYYY/MM/DD/slug), take the last part
    if segments.length >= 4 && segments[0..2].all? { |s| s.match?(/^\d+$/) }
      segments.last
    else
      segments.last
    end
  end

  def normalize_slug(slug)
    return nil if slug.blank?
    
    # Remove trailing slashes and normalize
    slug.to_s.gsub(/\/$/, '').parameterize
  end
end
