namespace :seo do
	desc "Isi Company Profile (tabel settings) & alamat kantor sesuai prisma-schema-spec.md"
	task seed_company_profile: :environment do
		setting = Setting.current

		setting.legal_name = StructuredData::Organization.facts['legal_name'] if setting.legal_name.blank?
		setting.alternate_name = 'Prisma Ads' if setting.alternate_name.blank?
		setting.email = configatron.info_email if setting.email.blank?
		setting.phone = configatron.company_phone1 if setting.phone.blank?
		setting.whatsapp = configatron.whatsapp_number if setting.whatsapp.blank?

		# Tahun pendirian dari spec. Hanya tahunnya yang dipakai di schema.
		setting.founding_date = Date.new(2004, 1, 1) if setting.founding_date.blank?

		# Spec hanya mencantumkan empat akun; Facebook dan Twitter/X sengaja tidak
		# masuk (sudah ditanyakan ke strategist, lihat Pertanyaan Terbuka di ROADMAP_PLAN.md).
		if setting.same_as_list.empty?
			setting.same_as = [
				configatron.social_instagram_url,
				configatron.social_linkedin_url,
				configatron.social_youtube_url,
				configatron.social_tiktok_url
			].compact_blank
		end

		# Deskripsi entitas versi spec, bukan deskripsi meta situs.
		descriptions = {
			id: 'Prisma Advertising (PT Prisma Harapan) adalah perusahaan media luar ruang ' \
					'(OOH dan DOOH) di Indonesia sejak 2004, dengan billboard statis dan videotron ' \
					'di Jakarta, Bandung, dan Bali.',
			en: 'Prisma Advertising (PT Prisma Harapan) is an Indonesian out-of-home (OOH and DOOH) ' \
					'media company founded in 2004, with static billboards and videotrons in Jakarta, ' \
					'Bandung and Bali.'
		}
		# Spec baris 20: halaman /cn memakai teks EN sampai salinan Mandarin tersedia.
		# Nilai CN ditulis eksplisit (sama dengan EN) supaya terlihat di admin dan tidak bergantung
		# pada fallback cn -> en (config/initializers/mobility.rb).
		descriptions[:cn] = descriptions[:en]

		descriptions.each do |locale, text|
			Mobility.with_locale(locale) do
				# `fallback: false` wajib di sini: tanpa itu :id/:cn yang kosong terbaca sebagai teks :en
				# (fallback id/cn -> en) sehingga dianggap sudah terisi dan versinya tidak ditulis.
				#
				# Nilai lama hasil seed pertama adalah salinan configatron.site_description
				# (deskripsi meta situs, bukan deskripsi entitas); itu pun dianggap kosong
				# supaya bisa diganti versi spec.
				current = setting.description(fallback: false).to_s.strip
				placeholder = current.blank? || current == configatron.site_description.to_s.strip
				setting.description = text if placeholder
			end
		end

		setting.save!
		puts "Company Profile tersimpan (id: #{setting.id})."

		# Alamat terstruktur kantor pusat. Kolomnya sudah ada sejak migrasi sebelumnya
		# tapi belum pernah diisi, sehingga schema jatuh ke `complete_address` apa adanya.
		#
		# CATATAN: nama jalan di spec ("GRHA PRISMA, Jl. Raya Kedoya No.38, Kedoya Selatan,
		# Kebon Jeruk") berbeda dari yang tampil di situs ("GRAHA PRISMA, Jl. Kedoya Duri
		# Raya No.38"). Sudah ditanyakan ke strategist; sementara memakai versi situs agar
		# schema tetap sama dengan konten yang terlihat.
		address = Address.primary
		if address
			address.street_address = 'GRAHA PRISMA, Jl. Kedoya Duri Raya No.38, Kedoya Selatan' if address.street_address.blank?
			address.locality = 'Jakarta Barat' if address.locality.blank?
			address.region = 'DKI Jakarta' if address.region.blank?
			address.postal_code = '11520' if address.postal_code.blank?
			address.country_code = 'ID' if address.country_code.blank?
			address.primary_office = true if Address.where(primary_office: true).none?
			address.save!
			puts "Alamat kantor pusat tersimpan (id: #{address.id}, primary: #{address.primary_office})."
		else
			puts "Tidak ada record Address — alamat terstruktur dilewati."
		end
	end

	desc "Buat halaman legal (Privacy Policy, Terms & Conditions, Editorial Standard) sebagai draft"
	task legal_pages: :environment do
		pages = [
			{
				title: 'Privacy Policy',
				slug: 'privacy-policy',
				meta_title: { en: 'Privacy Policy | Prisma Advertising', id: 'Kebijakan Privasi | Prisma Advertising' },
				meta_description: {
					en: 'How Prisma Advertising collects, uses, and protects your personal data.',
					id: 'Bagaimana Prisma Advertising mengumpulkan, menggunakan, dan melindungi data pribadi Anda.'
				},
				content: {
					en: <<~HTML,
						<h2>1. Introduction</h2>
						<p>[Isi oleh tim legal] Penjelasan singkat siapa Prisma Advertising dan cakupan kebijakan ini.</p>
						<h2>2. Data We Collect</h2>
						<p>[Isi oleh tim legal] Data dari formulir inquiry, lamaran kerja beserta CV, Google reCAPTCHA, dan Google Tag Manager.</p>
						<h2>3. How We Use Your Data</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>4. Data Sharing</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>5. Data Retention &amp; Security</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>6. Your Rights</h2>
						<p>[Isi oleh tim legal] Mengacu pada UU No. 27 Tahun 2022 tentang Pelindungan Data Pribadi.</p>
						<h2>7. Contact</h2>
						<p>[Isi oleh tim legal]</p>
					HTML
					id: <<~HTML
						<h2>1. Pendahuluan</h2>
						<p>[Isi oleh tim legal] Penjelasan singkat mengenai Prisma Advertising dan cakupan kebijakan ini.</p>
						<h2>2. Data yang Kami Kumpulkan</h2>
						<p>[Isi oleh tim legal] Data dari formulir inquiry, lamaran kerja beserta CV, Google reCAPTCHA, dan Google Tag Manager.</p>
						<h2>3. Penggunaan Data</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>4. Pembagian Data</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>5. Penyimpanan &amp; Keamanan Data</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>6. Hak Anda</h2>
						<p>[Isi oleh tim legal] Mengacu pada UU No. 27 Tahun 2022 tentang Pelindungan Data Pribadi.</p>
						<h2>7. Kontak</h2>
						<p>[Isi oleh tim legal]</p>
					HTML
				}
			},
			{
				title: 'Terms & Conditions',
				slug: 'terms',
				meta_title: { en: 'Terms & Conditions | Prisma Advertising', id: 'Syarat & Ketentuan | Prisma Advertising' },
				meta_description: {
					en: 'Terms governing the use of the Prisma Advertising website and services.',
					id: 'Ketentuan penggunaan situs dan layanan Prisma Advertising.'
				},
				content: {
					en: <<~HTML,
						<h2>1. Acceptance of Terms</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>2. Use of the Website</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>3. Intellectual Property</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>4. Service Terms</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>5. Limitation of Liability</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>6. Governing Law</h2>
						<p>[Isi oleh tim legal]</p>
					HTML
					id: <<~HTML
						<h2>1. Penerimaan Ketentuan</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>2. Penggunaan Situs</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>3. Hak Kekayaan Intelektual</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>4. Ketentuan Layanan</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>5. Batasan Tanggung Jawab</h2>
						<p>[Isi oleh tim legal]</p>
						<h2>6. Hukum yang Berlaku</h2>
						<p>[Isi oleh tim legal]</p>
					HTML
				}
			},
			{
				title: 'Editorial Standard',
				slug: 'editorial-standard',
				meta_title: { en: 'Editorial Standard | Prisma Advertising', id: 'Standar Editorial | Prisma Advertising' },
				meta_description: {
					en: 'How Prisma Advertising researches, writes, reviews, and updates its content.',
					id: 'Bagaimana Prisma Advertising meneliti, menulis, meninjau, dan memperbarui kontennya.'
				},
				content: {
					en: <<~HTML,
						<h2>Our Editorial Principles</h2>
						<p>[Isi oleh tim konten]</p>
						<h2>Research &amp; Sources</h2>
						<p>[Isi oleh tim konten]</p>
						<h2>Review Process</h2>
						<p>[Isi oleh tim konten]</p>
						<h2>Content Updates &amp; Corrections</h2>
						<p>[Isi oleh tim konten]</p>
						<h2>Use of AI</h2>
						<p>[Isi oleh tim konten]</p>
					HTML
					id: <<~HTML
						<h2>Prinsip Editorial Kami</h2>
						<p>[Isi oleh tim konten]</p>
						<h2>Riset &amp; Sumber</h2>
						<p>[Isi oleh tim konten]</p>
						<h2>Proses Peninjauan</h2>
						<p>[Isi oleh tim konten]</p>
						<h2>Pembaruan &amp; Koreksi Konten</h2>
						<p>[Isi oleh tim konten]</p>
						<h2>Penggunaan AI</h2>
						<p>[Isi oleh tim konten]</p>
					HTML
				}
			}
		]

		pages.each do |attrs|
			page = Page.find_by(title: attrs[:title])

			if page
				# URL halaman legal ditetapkan client (/privacy-policy dan /terms), jadi slug
				# dipaksa sesuai daftar di atas, bukan hasil generate FriendlyId dari judul.
				if page.slug != attrs[:slug]
					old_slug = page.slug
					page.update_columns(slug: attrs[:slug])
					puts "Slug '#{attrs[:title]}' diubah: #{old_slug} -> #{attrs[:slug]}."
				else
					puts "Lewati '#{attrs[:title]}' — halaman sudah ada (slug: #{page.slug})."
				end
				next
			end

			page = Page.new(title: attrs[:title], status: 0, published_date: Time.current)

			seo = page.build_seo_setting
			%i[en id].each do |locale|
				Mobility.with_locale(locale) do
					seo.meta_title = attrs[:meta_title][locale]
					seo.meta_description = attrs[:meta_description][locale]
					page.content = attrs[:content][locale]
				end
			end

			page.save!
			# FriendlyId membangkitkan slug dari judul (`should_generate_new_friendly_id?` =
			# `title_changed?`), jadi slug yang ditetapkan client dipaksa setelah save.
			page.update_columns(slug: attrs[:slug]) if page.slug != attrs[:slug]
			puts "Dibuat '#{page.title}' sebagai DRAFT (slug: #{attrs[:slug]})."
		end

		puts "Selesai. Isi teksnya lewat admin, lalu ubah status ke Published agar muncul di footer."
	end

	desc "Isi field terstruktur billboard dari teks bebas yang sudah ada (hanya yang masih kosong)"
	task backfill_billboards: :environment do
		# Kota dikenali dari pola nama, bukan posisi koma, karena `address` tidak
		# konsisten: kota bisa di segmen ke-2 ("…, Bekasi Barat (…)") atau ke-3
		# ("…, Kelapa Gading, North Jakarta (…)"). Sekaligus menyeragamkan nama
		# yang di data lama tercampur Inggris dan Indonesia.
		cities = [
			[/\b(south|selatan)\s*jakarta|jakarta\s*selatan\b/i, 'Jakarta Selatan', 'DKI Jakarta'],
			[/\b(north|utara)\s*jakarta|jakarta\s*utara\b/i,     'Jakarta Utara',   'DKI Jakarta'],
			[/\b(west|barat)\s*jakarta|jakarta\s*barat\b/i,      'Jakarta Barat',   'DKI Jakarta'],
			[/\b(east|timur)\s*jakarta|jakarta\s*timur\b/i,      'Jakarta Timur',   'DKI Jakarta'],
			[/\b(central)\s*jakarta|jakarta\s*pusat\b/i,         'Jakarta Pusat',   'DKI Jakarta'],
			[/\btangerang\s*selatan\b/i,                          'Tangerang Selatan', 'Banten'],
			[/\btangerang\b/i,                                    'Tangerang',       'Banten'],
			[/\bserpong\b/i,                                      'Tangerang Selatan', 'Banten'],
			[/\bbekasi\b/i,                                       'Bekasi',          'Jawa Barat'],
			[/\bdepok\b/i,                                        'Depok',           'Jawa Barat'],
			[/\bbogor\b/i,                                        'Bogor',           'Jawa Barat'],
			[/\bcikarang\b/i,                                     'Cikarang',        'Jawa Barat'],
			[/\bcimahi\b/i,                                       'Cimahi',          'Jawa Barat'],
			[/\bbandung\b/i,                                      'Bandung',         'Jawa Barat'],
			[/\bdenpasar\b/i,                                     'Denpasar',        'Bali'],
			[/\b(badung|kuta)\b/i,                                'Badung',          'Bali'],
			# Paling generik, ditaruh terakhir supaya alamat seperti
			# "Jl. Tol Jakarta-Tangerang ... Tangerang" tidak terbaca sebagai Jakarta.
			[/\bjakarta\b/i,                                      'Jakarta',         'DKI Jakarta']
		]

		filled = Hash.new(0)
		skipped = 0

		Product.unscoped.find_each do |product|
			changes = {}

			# "6m (h) x 30m (w) - Front Light" -> "6m (h) x 30m (w)"; satuan cm juga ada.
			if product.size.blank? && (m = product.specification.to_s.match(/\d+\s*c?m\s*\(h\).*?\(w\)/i))
				changes[:size] = m[0].strip
			end

			# Pencahayaan hanya tersirat di 62 dari 86 record; sisanya memuat jumlah unit
			# atau catatan lain, jadi dibiarkan kosong.
			if product.lighting.blank?
				case product.specification.to_s
				when /front\s*light/i then changes[:lighting] = 'Front Light'
				when /back\s*light/i  then changes[:lighting] = 'Back Light'
				end
			end

			# "133.376 impression/day" -> 133376 (titik = pemisah ribuan)
			if product.impressions_per_day.blank? && (m = product.est_impression.to_s.match(/[\d.,]+/))
				digits = m[0].gsub(/[.,]/, '')
				changes[:impressions_per_day] = digits.to_i if digits.present? && digits.to_i.positive?
			end

			# Hanya alamat yang dicocokkan. Nama titik tidak dipakai karena menyebut kota
			# tujuan jalan tol ("Tol Pasteur ... Bandung to Jakarta"), yang membuat
			# empat titik Bandung sempat terbaca sebagai Jakarta.
			_, city, region = cities.find { |pattern, _, _| product.address.to_s.match?(pattern) }

			# Alamat yang tidak menyebut kota mana pun mewarisi dari lokasi induknya.
			if city.blank? && product.location&.name.present?
				_, city, region = cities.find { |pattern, _, _| product.location.name.match?(pattern) }
			end

			changes[:city] = city if product.city.blank? && city.present?
			changes[:region] = region if product.region.blank? && region.present?

			if changes.any?
				product.update_columns(changes)
				changes.each_key { |k| filled[k] += 1 }
			else
				skipped += 1
			end
		end

		puts "Terisi: #{filled.map { |k, v| "#{k}=#{v}" }.join(', ')}" if filled.any?
		puts "Dilewati (sudah lengkap atau tidak bisa di-parse): #{skipped}"
		puts "Nilai di atas adalah DRAFT hasil parse teks bebas — mohon dikoreksi tim SEO lewat admin."
		puts "Kolom yang tidak terisi otomatis: slot_duration & operating_hours (khusus titik LED, tidak ada di data lama)."
	end

	desc "Isi field schema layanan (serviceType, areaServed, provider) sesuai prisma-schema-spec.md"
	task seed_services: :environment do
		# Hanya nilai yang ada di spec. `name` dan `description` TIDAK ditimpa karena
		# schema harus sama dengan teks yang tampil di halaman, dan nama versi spec
		# berbeda dari nama di CMS (mis. "Sewa Billboard Statis" vs "Papan Reklame
		# Statis") — mengubahnya butuh persetujuan Prisma, lihat ROADMAP_PLAN.md.
		specs = {
			'static-billboard-advertising' => {
				service_type: 'Billboard advertising',
				area: [%w[City Jakarta], %w[City Tangerang], %w[City Bekasi], %w[City Bandung]]
			},
			'digital-billboard-advertising' => {
				service_type: 'Digital billboard / videotron advertising',
				area: [%w[City Jakarta], %w[City Bandung], %w[City Denpasar]]
			},
			'transit-advertising' => {
				service_type: 'Transit advertising',
				area: [%w[Country Indonesia]]
			},
			'creative-ooh-branding' => {
				service_type: 'Creative OOH / 3D billboard',
				area: [%w[Country Indonesia]]
			},
			'ooh-dashboard' => {
				service_type: 'OOH campaign monitoring dashboard',
				area: [%w[Country Indonesia]]
			},
			'pix-creative-mindworks' => {
				service_type: '3D animation and anamorphic content production',
				area: [%w[Country Indonesia]],
				provider: 'https://pixcreativemindworks.com/#organization'
			}
		}

		missing = []
		specs.each do |slug, attrs|
			service = Service.find_by(slug: slug)
			if service.nil?
				missing << slug
				next
			end

			service.service_type = attrs[:service_type] if service.service_type.blank?
			if Array(service.area_served).empty?
				service.area_served = attrs[:area].map { |type, name| { 'type' => type, 'name' => name } }
			end
			service.schema_provider_url = attrs[:provider] if attrs[:provider] && service.schema_provider_url.blank?
			service.save!
			puts "#{slug}: serviceType=#{service.service_type}"
		end

		puts "Slug tidak ditemukan: #{missing.join(', ')}" if missing.any?
	end

	desc "Audit title & description tiap halaman: kosong/default, terlalu panjang atau pendek, duplikat (per bahasa). SAVE=1 menyimpan JSON seperti menu admin SEO Audit"
	task audit: :environment do
		# Logika di SeoAudit (dipakai juga menu admin SEO -> SEO Audit). Tanpa HTTP, jadi aman di server.
		result = SeoAudit.run
		SeoAudit::LOCALES.each do |locale|
			rows = result[:rows].select { |r| r[:locale] == locale.to_s }
			issues = result[:findings].select { |f| f[:locale] == locale.to_s }
			puts "\n=== #{locale.to_s.upcase}: #{rows.size} halaman dicek, #{issues.size} temuan ==="
			issues.each { |f| puts "  - #{f[:label]}: #{f[:message]}" }
		end

		puts "\nTotal temuan: #{result[:findings].size}"
		puts "Catatan: title/description 'default situs' berarti record belum punya data untuk dirakit otomatis."
		puts "Disimpan: tmp/seo_audit/#{SeoAudit.save(result)}" if ENV['SAVE'].present?
	end

	desc "Jalankan seluruh setup SEO Week 1"
	task setup: %i[seed_company_profile seed_services legal_pages backfill_billboards]

  desc "Audit fallback Mobility: record yang kosong di EN tetapi terisi di ID/CN, dan salinan identik EN=ID (read-only)"
  task fallback_audit: :environment do
    # Aturan: id/cn kosong -> EN; EN kosong tetap kosong. Record "hanya-ID" menampilkan teks kosong di situs EN.
    Rails.application.eager_load!
    models = ApplicationRecord.descendants.select { |k| k.respond_to?(:mobility_attributes) && k.mobility_attributes.any? && k.table_exists? }
    lines = []
    models.sort_by(&:name).each do |klass|
      klass.mobility_attributes.each do |attr|
        next unless klass.column_names.include?(attr) # ActionText (content) dibaca terpisah di bawah
        only_other = []
        same = 0
        klass.unscoped.find_each do |r|
          raw = r.read_attribute(attr)
          next unless raw.is_a?(Hash)
          en = raw['en'].to_s.strip
          others = %w[id cn].select { |l| raw[l].to_s.strip.present? }
          only_other << (r.try(:slug) || r.id) if en.empty? && others.any?
          same += 1 if en.present? && raw['id'].to_s.strip == en
        end
        next if only_other.empty? && same.zero?
        lines << "#{klass.name}.#{attr}: EN kosong tapi ID/CN terisi=#{only_other.size}; EN==ID identik=#{same}"
        lines << "  contoh slug/id: #{only_other.first(15).join(', ')}" if only_other.any?
      end
    end
    # content (ActionText) per record: body ID/CN ada, EN kosong
    ActionText::RichText.where(name: 'content').group_by { |rt| [rt.record_type, rt.record_id] }.each_with_object(Hash.new(0)) do |((type, _), rts), acc|
      has = ->(l) { rts.any? { |rt| rt.locale.to_s == l && rt.body.present? } }
      acc[type] += 1 if !has.('en') && (has.('id') || has.('cn'))
    end.each { |type, n| lines << "#{type}.content: EN kosong tapi ID/CN terisi=#{n}" }
    puts lines.empty? ? 'Tidak ada record terdampak.' : lines.join("\n")
  end
end
