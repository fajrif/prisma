# Menangani URL warisan WordPress dan struktur lama. Peta tujuannya ada di
# config/redirects.yml, dibaca lewat RedirectMap.
class RedirectsController < ApplicationController
  # /YYYY/MM/DD/slug/ -> /articles/:slug
  def legacy_blog
    slug = extract_slug_from_path(params[:path])
    article_slug = resolve_article_slug(slug)

    return redirect_to_article(article_slug) if article_slug.present?

    # Tidak ada padanan: arahkan ke indeks artikel.
    redirect_to localized('/articles'), status: :moved_permanently, allow_other_host: false
  end

  # /works/:slug -> /campaigns/:slug
  def legacy_works
    portfolio = Portfolio.friendly.find_by(slug: params[:slug]) if params[:slug].present?

    if portfolio
      redirect_to portfolio_path(portfolio), status: :moved_permanently
    else
      redirect_to portfolios_path, status: :moved_permanently
    end
  end

  # Unggahan WordPress lama sudah tidak ada dan tidak punya padanan -> 410 Gone.
  def legacy_wp_content
    head :gone
  end

  # /products/:slug dan /locations/{location}/{area}/:slug -> /billboards/{slug}, satu hop.
  def billboard
    product = Product.unscoped.find_by(slug: params[:id].to_s)
    raise ActiveRecord::RecordNotFound, 'Billboard not found' unless product

    redirect_to product.public_path, status: :moved_permanently, allow_other_host: false
  end

  # Slug halaman lama, dipetakan di config/redirects.yml.
  def legacy_page
    target = RedirectMap.legacy_page(params[:slug])

    # Target "billboard:<slug>" dihitung dari data, supaya tetap satu hop saat titik pindah area.
    if target.to_s.start_with?('billboard:')
      product = Product.unscoped.find_by(slug: target.delete_prefix('billboard:'))
      return redirect_to(product.public_path, status: :moved_permanently, allow_other_host: false) if product

      target = '/locations'
    end

    # Slug yang tidak dikenal diarahkan ke beranda, bukan 404, karena route ini
    # hanya dipasang untuk URL yang memang pernah ada dan masih punya backlink.
    redirect_to localized(target || '/'), status: :moved_permanently, allow_other_host: false
  end

  private

  # Mengubah slug lama jadi slug artikel yang hidup sekarang.
  def resolve_article_slug(slug)
    return nil if slug.blank?

    normalized = slug.to_s.chomp('/').parameterize
    mapped = RedirectMap.article(normalized) || normalized
    Article.exists?(slug: mapped) ? mapped : nil
  end

  def redirect_to_article(slug)
    forced = RedirectMap.article_locale(slug)
    prefix = forced.present? ? "/#{forced}" : locale_prefix_path
    redirect_to "#{prefix}/articles/#{slug}", status: :moved_permanently, allow_other_host: false
  end

  # Menambahkan prefix bahasa permintaan ke path tujuan.
  def localized(path)
    return path if path.start_with?('http')

    prefix = locale_prefix_path
    path == '/' ? (prefix.presence || '/') : "#{prefix}#{path}"
  end

  def locale_prefix_path
    I18n.locale.to_sym == I18n.default_locale.to_sym ? '' : "/#{I18n.locale}"
  end

  def extract_slug_from_path(path)
    return nil if path.blank?

    path.to_s.split('/').reject(&:blank?).last
  end
end
