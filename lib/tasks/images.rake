namespace :images do
	desc "Cek apakah ImageMagick di mesin ini bisa menulis WebP (menentukan variant WebP otomatis)"
	task check_webp: :environment do
		out = `convert -list format 2>/dev/null | grep -E '^\\s*WEBP'`
		out = `magick -list format 2>/dev/null | grep -E '^\\s*WEBP'` if out.blank?
		puts out.present? ? "WebP didukung:\n#{out}\nVariant WebP aktif otomatis (IMAGE_WEBP=0 untuk mematikan). PerformanceHelper.webp? => #{PerformanceHelper.webp?}" : "WebP TIDAK didukung ImageMagick di mesin ini; variant tetap PNG/JPEG. PerformanceHelper.webp? => #{PerformanceHelper.webp?}"
	end

	desc "Buat variant gambar (ukuran yang dipakai halaman publik) lebih dulu agar pengunjung pertama tidak menunggu"
	task warm: :environment do
		helper = Class.new { include PerformanceHelper }.new
		plan = {
			# Gambar hero (hero_bg_style) dipakai dalam dua ukuran: 1200 (HP) dan 1920 (layar lebar).
			# Gambar kartu (opt_image_tag dengan sizes:) memakai srcset 480 + 800.
			Article => { image: [480, 800, 1200, 1920] }, Portfolio => { image: [480, 800], banner: [1200, 1920], image1: [1200], image2: [1200] },
			Service => { image: [800], image1: [480, 800] }, Industry => { image: [1200] },
			Banner => { image: [1200, 1920] }, Location => { image: [488] }, Snippet => { image: [1200, 1920], background: [1920] },
			Product => { banner: [1200, 1920], image1: [1200], image2: [1200] }
		}
		done = 0
		plan.each do |klass, attrs|
			klass.unscoped.find_each do |record|
				attrs.each do |attr, widths|
					next unless record.respond_to?(attr)

					widths.each do |w|
						variant = helper.opt_image(record.public_send(attr), w)
						next unless variant.respond_to?(:processed)

						variant.processed
						done += 1
					rescue StandardError => e
						warn "#{klass.name}##{record.id}.#{attr}@#{w}: #{e.class} #{e.message.truncate(80)}"
					end
				end
			end
			puts "#{klass.name}: selesai"
		end
		Product.unscoped.find_each do |product|
			[500, Product::LIST_THUMB_SIZE].each do |size|
				product.image_thumb_variant(size)&.processed
				done += 1
			end
		rescue StandardError => e
			warn "Product##{product.id} thumb: #{e.class} #{e.message.truncate(80)}"
		end
		puts "#{done} variant diproses"
	end
end
