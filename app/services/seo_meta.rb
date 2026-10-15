# Menentukan title, description, dan metadata sosial sebuah halaman.
#
# Rantai fallback (urutan prioritas, sesuai brief T7):
#   1. seo_settings   -> diisi tim SEO lewat form "SEO & Social" di admin (satu-satunya sumber
#                        meta title/description; kolom meta_title lama di model sudah tidak dibaca)
#   2. generated      -> dirakit dari data record + template di config/locales (seo.*)
#   3. default situs  -> configatron.site_title / site_description
#
# Field sosial tingkat 1 dibaca dengan `fallback: false`. Mobility punya fallback en<->id, jadi tanpa
# itu teks yang hanya diisi dalam bahasa Indonesia akan muncul di halaman Inggris. Lebih
# baik jatuh ke tingkat berikutnya daripada menampilkan teks berbahasa salah.
class SeoMeta
	# Aturan panjang (karakter) yang dibaca mesin pencari. Batas atas: sisanya terpotong di hasil
	# pencarian. Batas bawah: terlalu pendek = peluang menjelaskan halaman terbuang. Dipakai form
	# SEO & Social (penghitung langsung), ringkasan admin, dan rake seo:audit.
	TITLE_MIN = 20
	TITLE_LIMIT = 60
	DESCRIPTION_MIN = 70
	DESCRIPTION_LIMIT = 160
	DEFAULT_ROBOTS = 'index, follow'.freeze
	OG_TYPES = %w[website article].freeze
	TWITTER_CARDS = %w[summary summary_large_image].freeze
	ROBOTS_TOKENS = %w[index noindex follow nofollow noarchive nosnippet noimageindex].freeze

	# Yang dikembalikan #source: dari tingkat mana nilai berasal.
	SOURCES = %i[seo_settings generated default].freeze

	def initialize(record: nil, controller: nil, action: nil)
		@record = record
		@controller = controller.to_s
		@action = action.to_s
	end

	def title
		resolve_title.first
	end

	def description
		resolve_description.first
	end

	# [:seo_settings | :generated | :default] — dipakai rake seo:audit & panel admin
	def title_source
		resolve_title.last
	end

	def description_source
		resolve_description.last
	end

	def og_title
		seo_text(:og_title) || title
	end

	def og_description
		seo_text(:og_description) || description
	end

	def og_type
		value = seo&.og_type.to_s.strip
		return value if OG_TYPES.include?(value)

		@record.is_a?(::Article) ? 'article' : 'website'
	end

	def twitter_card
		value = seo&.twitter_card.to_s.strip
		TWITTER_CARDS.include?(value) ? value : 'summary_large_image'
	end

	# Hanya token yang dikenal yang lolos. Nilai sembarang (typo atau string bebas) jatuh
	# ke default supaya halaman tidak tanpa sengaja ter-noindex.
	def robots
		tokens = seo&.robots.to_s.downcase.split(',').map(&:strip).reject(&:blank?)
		return DEFAULT_ROBOTS if tokens.empty? || (tokens - ROBOTS_TOKENS).any?

		tokens.uniq.join(', ')
	end

	# Hanya path internal atau URL di host kanonik. URL ke host lain diabaikan.
	def canonical_override
		raw = seo&.canonical_override.to_s.strip
		return if raw.blank?

		base = configatron.site_url
		return "#{base}#{raw}" if raw.start_with?('/') && !raw.start_with?('//')

		raw if raw == base || raw.start_with?("#{base}/")
	end

	# Gambar share: seo_settings.og_image -> gambar record -> nil (layout memakai logo).
	def image_url
		attachment_url(seo&.og_image) || attachment_url(record_image)
	end

	# Nilai yang dipakai situs bila field SEO & Social dikosongkan (dirakit otomatis, lalu default
	# situs). Dipakai form admin sebagai placeholder dan dasar penghitung panjang.
	def automatic_title
		generated_title.presence || configatron.site_title
	end

	def automatic_description
		generated_description.presence || configatron.site_description
	end

	# Panjang yang dibaca mesin pencari, dipakai audit.
	def title_length
		title.to_s.length
	end

	def description_length
		description.to_s.length
	end

	private

	def seo
		@seo ||= @record.respond_to?(:seo_setting) ? @record.seo_setting : nil
	end

	def seo_text(attr)
		return unless seo

		seo.public_send(attr, fallback: false).presence
	end

	def resolve_title
		@resolve_title ||= with_cn_fallback { title_chain }
	end

	def resolve_description
		@resolve_description ||= with_cn_fallback { description_chain }
	end

	# Meta title/description MEMAKAI fallback Mobility (id/cn -> en; en tanpa fallback): halaman
	# /id yang hanya punya meta berbahasa Inggris (isi strategist) memakai teks EN, bukan teks dirakit. Field sosial (og_*) tetap
	# fallback: false. Mengubah ini ke fallback: false = keputusan SEO terpisah.
	def seo_meta_text(attr)
		return unless seo

		seo.public_send(attr).presence
	end

	def title_chain
		if (v = seo_meta_text(:meta_title)) then [v, :seo_settings]
		elsif (v = generated_title) then [v, :generated]
		else [configatron.site_title, :default]
		end
	end

	def description_chain
		if (v = seo_meta_text(:meta_description)) then [v, :seo_settings]
		elsif (v = generated_description) then [v, :generated]
		else [configatron.site_description, :default]
		end
	end

	# Spec: /cn memakai teks Inggris sampai salinan Mandarin ada. Field yang kosong di CN sudah
	# jatuh ke EN lewat Mobility; ini hanya pengaman bila seluruh rantai CN berakhir di default
	# situs (berbahasa Indonesia): rantai dihitung ulang dalam bahasa Inggris.
	def with_cn_fallback
		result = yield
		return result unless result.last == :default && I18n.locale.to_sym == :cn

		en_result = I18n.with_locale(:en) { yield }
		en_result.last == :default ? result : en_result
	end

	# --- generated -----------------------------------------------------------

	def generated_title
		case @record
		when ::Product then product_title
		when ::Location then with_site(I18n.t('seo.location.title', name: @record.name))
		when ::Area then area_title
		when ::Career then with_site(I18n.t('seo.career.title', title: @record.title))
		when ::Article, ::Page then with_site(@record.title)
		when ::Portfolio then @record.name # tanpa akhiran situs, seperti sebelum meta dipindah
		when ::Service, ::Industry then with_site(@record.name)
		when nil then index_text(:title) && with_site(index_text(:title))
		end
	end

	def generated_description
		case @record
		when ::Product then product_description
		when ::Location then location_description
		when ::Area then area_description
		when ::Article, ::Career then clip(plain(@record.short_description))
		when ::Service, ::Portfolio then clip(plain(@record.short_description))
		when ::Industry then clip(plain(@record.caption.presence || @record.description))
		when nil then index_text(:description)
		end
	end

	# Mencoba bentuk terpanjang dulu, lalu menyusut: tanpa kota, lalu nama saja.
	# Title billboard sering panjang ("Brin Grande LED Gatot Subroto"), dan kota lebih
	# berharga daripada akhiran situs.
	def product_title
		type = billboard_type_label
		city = @record.city.presence
		candidates = []
		candidates << I18n.t('seo.product.title', name: @record.name, type: type, city: city) if city
		candidates << I18n.t('seo.product.title_no_city', name: @record.name, type: type)

		candidates.find { |c| c.length <= TITLE_LIMIT } || candidates.last.truncate(TITLE_LIMIT, separator: ' ')
	end

	# Bagian disusun berurutan; yang tidak muat di batas panjang dibuang dari belakang,
	# sehingga kalimat pembuka selalu ada dan tidak ada kalimat yang terpotong di tengah.
	def product_description
		city = @record.city.presence
		# Huruf kecil di tengah kalimat ("is a digital billboard in Bandung"); title tetap kapital.
		type = billboard_type_label.downcase
		intro = if city
			I18n.t('seo.product.intro', name: @record.name, type: type, city: city)
		else
			I18n.t('seo.product.intro_no_city', name: @record.name, type: type)
		end

		parts = [intro]
		parts << I18n.t('seo.product.size', size: @record.size) if @record.size.present?
		if @record.impressions_per_day.to_i.positive?
			parts << I18n.t('seo.product.impressions', count: impressions_text)
		end
		parts << I18n.t('seo.product.closing')

		parts.each_with_object([]) do |part, kept|
			candidate = (kept + [part]).join(' ')
			kept << part if kept.empty? || candidate.length <= DESCRIPTION_LIMIT
		end.join(' ')
	end

	# Pemisah ribuan mengikuti bahasa: titik di Indonesia ("46.694"), koma di Inggris ("46,694").
	# Titik di teks Inggris terbaca sebagai desimal.
	def impressions_text
		delimiter = I18n.locale.to_sym == :id ? '.' : ','
		ActiveSupport::NumberHelper.number_to_delimited(@record.impressions_per_day, delimiter: delimiter)
	end

	def location_description
		own = clip(plain(@record.description))
		return own if own.present?

		count = @record.respond_to?(:products) ? @record.products.count : 0
		I18n.t('seo.location.description', name: @record.name, count: count) if count.positive?
	end

	# "Billboard di Jakarta Pusat, Jakarta | Prisma Advertising"; nama lokasi dibuang bila tidak muat,
	# daripada nama area terpotong.
	def area_title
		full = with_site(I18n.t('seo.area.title', area: @record.name, location: @record.location.name))
		return full unless full.include?('...')

		with_site(I18n.t('locations.area_title', area: @record.name))
	end

	def area_description
		own = clip(plain(@record.description))
		return own if own.present?

		I18n.t('seo.area.description', area: @record.name, location: @record.location.name, count: @record.products.count)
	end

	def billboard_type_label
		I18n.t("seo.billboard_type.#{@record.billboard_type}", default: @record.billboard_type_label)
	end

	def index_text(key)
		return unless @controller.present?

		# /contact-us adalah inquiries#show, jadi controller saja yang menentukan.
		return unless @action == 'index' || @controller == 'inquiries'

		I18n.t("seo.index.#{@controller}.#{key}", default: nil).presence
	end

	# --- util ------------------------------------------------------------------

	# Menambahkan " | Prisma Advertising" bila muat; bagian utama dipangkas lebih dulu
	# supaya akhiran tidak terpotong.
	def with_site(main)
		return if main.blank?

		suffix = " | #{I18n.t('seo.site')}"
		return main.truncate(TITLE_LIMIT, separator: ' ') if main.length >= TITLE_LIMIT

		"#{main.truncate(TITLE_LIMIT - suffix.length, separator: ' ')}#{suffix}".then do |full|
			full.length <= TITLE_LIMIT ? full : main
		end
	end

	def plain(html)
		text = ActionView::Base.full_sanitizer.sanitize(html.to_s).to_s.squish
		text.presence
	end

	def clip(text)
		text&.truncate(DESCRIPTION_LIMIT, separator: ' ')
	end

	def record_image
		case @record
		when ::Article, ::Product, ::Location, ::Portfolio, ::Industry then @record.image
		when ::Area then @record.location.image
		when ::Service then @record.image1
		end
	end

	# Varian dibatasi 1200px agar og:image tidak berupa file asli yang bisa berukuran
	# puluhan MB (batas upload model 50MB).
	def attachment_url(attachment)
		return unless attachment.respond_to?(:attached?) && attachment.attached?

		source = attachment.variable? ? attachment.variant(resize_to_limit: [1200, 1200]) : attachment
		url = Rails.application.routes.url_helpers.url_for(source)
		Rails.env.production? ? url.sub(%r{\Ahttps?://[^/]+}, configatron.site_url) : url
	rescue StandardError => e
		Rails.logger.warn("[SeoMeta] cannot build image url: #{e.message}")
		nil
	end
end
