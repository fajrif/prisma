# T15: gambar Active Storage dikirim sebagai variant berukuran sesuai tampilan (bukan file asli
# berukuran MB), lengkap dengan width/height agar tidak menggeser layout (CLS) dan lazy-loading.
module PerformanceHelper
	# Di bawah ukuran ini file asli dipakai apa adanya (variant tidak sepadan dengan biayanya).
	MIN_BYTES = 60.kilobytes
	# Format yang aman di-resize; GIF dilewati agar animasinya tidak hilang, SVG tidak butuh raster.
	RESIZABLE = %w[image/png image/jpeg image/webp].freeze

	# Variant WebP dipakai bila ImageMagick mesin ini mendukungnya (dicek sekali, lalu diingat).
	# IMAGE_WEBP=0 mematikan, IMAGE_WEBP=1 memaksa nyala.
	def self.webp?
		return @webp unless @webp.nil?

		@webp = case ENV['IMAGE_WEBP']
		        when '0' then false
		        when '1' then true
		        else
			        %w[magick convert].any? { |bin| IO.popen([bin, '-list', 'format'], err: File::NULL, &:read).to_s.match?(/^\s*WEBP/) rescue false }
		        end
	end

	# Variant (atau attachment asli bila tidak perlu/bisa di-resize). nil bila belum terpasang.
	def opt_image(attachment, width)
		return unless attachment.respond_to?(:attached?) && attachment.attached?

		blob = attachment.blob
		return attachment unless RESIZABLE.include?(blob.content_type) && blob.byte_size > MIN_BYTES && attachment.variable?

		opts = { resize_to_limit: [width, nil], saver: { strip: true, quality: 80 } }
		opts[:format] = :webp if PerformanceHelper.webp?
		attachment.variant(opts)
	end

	def opt_image_url(attachment, width)
		img = opt_image(attachment, width)
		img && url_for(img)
	end

	# Lebar tambahan untuk srcset. 480: kartu grid desktop (±430px) dan kolom sempit; HP 1 kolom
	# (±380px x DPR 2) tetap memakai `width` (800).
	SRCSET_WIDTHS = [480].freeze
	# `sizes` untuk kartu grid tema (.grid xs-grid-1col / sm,md-grid-2col / 3col, container 1170px).
	CARD_SIZES = '(max-width: 575px) 100vw, (max-width: 991px) 50vw, 430px'.freeze

	# image_tag untuk attachment; width/height dihitung dari metadata blob (skala ke `width`).
	# nil bila belum terpasang. `loading: 'eager'` untuk gambar di atas lipatan.
	# `sizes:` (lebar tampil) menambah srcset dari SRCSET_WIDTHS + `width`, sehingga browser memilih
	# variant terkecil yang cukup. Hanya untuk gambar yang di-resize (file kecil/GIF/SVG tetap satu URL).
	def opt_image_tag(attachment, width, options = {})
		img = opt_image(attachment, width)
		return unless img

		sizes = options.delete(:sizes)
		blob = attachment.blob
		ow = blob.metadata[:width].to_i
		oh = blob.metadata[:height].to_i
		if ow.positive? && oh.positive? && !options.key?(:width)
			w = [ow, width].min
			options = options.merge(width: w, height: (oh * w / ow.to_f).round)
		end
		if sizes && img != attachment && ow.positive?
			# [lebar diminta, lebar hasil]: resize_to_limit tidak memperbesar, jadi gambar asli yang lebih
			# kecil menghasilkan lebar yang sama (dibuang uniq). URL memakai lebar diminta agar variant src dipakai ulang.
			candidates = (SRCSET_WIDTHS.select { |sw| sw < width } + [width]).map { |sw| [sw, [sw, ow].min] }
			candidates = candidates.reverse.uniq(&:last).reverse
			if candidates.size > 1
				srcset = candidates.map { |sw, actual| "#{url_for(opt_image(attachment, sw))} #{actual}w" }.join(', ')
				options = options.merge(srcset: srcset, sizes: sizes)
			end
		end
		image_tag(img, options)
	end

	# true bila rasio lebar:tinggi file asli logo > ambang (landscape), dipakai untuk memilih
	# layout "logo di atas judul" (stacked) alih-alih "logo di samping judul" di kartu services.
	WIDE_LOGO_RATIO = 1.5

	def wide_logo?(attachment, threshold: WIDE_LOGO_RATIO)
		return false unless attachment.respond_to?(:attached?) && attachment.attached?

		blob = attachment.blob
		w = blob.metadata[:width].to_i
		h = blob.metadata[:height].to_i
		return false unless w.positive? && h.positive?

		(w.to_f / h) > threshold
	end

	# Gambar hero dipasang sebagai background CSS, sehingga browser baru menemukannya setelah CSS
	# diproses dan memberinya prioritas rendah, padahal gambar inilah yang sering menjadi LCP.
	# Helper ini memberi dua ukuran (HP 1200px, layar lebar 1920px) lewat custom property yang dipilih
	# media query di kelas `hero-bg` (application.css). Hero pertama di halaman juga mendapat
	# <link rel="preload" fetchpriority="high"> di <head> (yield :hero_preload) dengan media query
	# yang sama, jadi hanya satu ukuran yang diunduh. Dipakai sebagai isi atribut style.
	HERO_MOBILE_MAX = 767

	def hero_bg_style(attachment, preload: true)
		sm = opt_image_url(attachment, 1200)
		lg = opt_image_url(attachment, 1920)
		return '' unless sm && lg

		if preload && !@hero_preloaded
			@hero_preloaded = true
			content_for :hero_preload, safe_join([
				tag.link(rel: 'preload', as: 'image', href: sm, media: "(max-width: #{HERO_MOBILE_MAX}px)", fetchpriority: 'high'),
				tag.link(rel: 'preload', as: 'image', href: lg, media: "(min-width: #{HERO_MOBILE_MAX + 1}px)", fetchpriority: 'high')
			], "\n")
		end
		"--hero-sm:url('#{sm}');--hero-lg:url('#{lg}');"
	end
end
