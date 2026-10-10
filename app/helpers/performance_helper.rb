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

	# image_tag untuk attachment; width/height dihitung dari metadata blob (skala ke `width`).
	# nil bila belum terpasang. `loading: 'eager'` untuk gambar di atas lipatan.
	def opt_image_tag(attachment, width, options = {})
		img = opt_image(attachment, width)
		return unless img

		blob = attachment.blob
		ow = blob.metadata[:width].to_i
		oh = blob.metadata[:height].to_i
		if ow.positive? && oh.positive? && !options.key?(:width)
			w = [ow, width].min
			options = options.merge(width: w, height: (oh * w / ow.to_f).round)
		end
		image_tag(img, options)
	end
end
