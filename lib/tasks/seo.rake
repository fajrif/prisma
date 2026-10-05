namespace :seo do
	desc "Isi Company Profile (tabel settings) dari nilai configatron bila masih kosong"
	task seed_company_profile: :environment do
		setting = Setting.current

		setting.legal_name = configatron.email_name if setting.legal_name.blank?
		setting.alternate_name = 'Prisma Ads' if setting.alternate_name.blank?
		setting.email = configatron.info_email if setting.email.blank?
		setting.phone = configatron.company_phone1 if setting.phone.blank?
		setting.whatsapp = configatron.whatsapp_number if setting.whatsapp.blank?

		if setting.same_as_list.empty?
			setting.same_as = [
				configatron.social_facebook_url,
				configatron.social_linkedin_url,
				configatron.social_instagram_url,
				configatron.social_twitter_url,
				configatron.social_youtube_url,
				configatron.social_tiktok_url
			].compact_blank
		end

		Mobility.with_locale(:en) do
			setting.description = configatron.site_description if setting.description.blank?
		end

		setting.save!
		puts "Company Profile tersimpan (id: #{setting.id})."
	end

	desc "Buat halaman legal (Privacy Policy, Terms & Conditions, Editorial Standard) sebagai draft"
	task legal_pages: :environment do
		pages = [
			{
				title: 'Privacy Policy',
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
				puts "Lewati '#{attrs[:title]}' — halaman sudah ada (slug: #{page.slug})."
				next
			end

			page = Page.new(title: attrs[:title], status: 0, published_date: Time.current)

			%i[en id].each do |locale|
				Mobility.with_locale(locale) do
					page.meta_title = attrs[:meta_title][locale]
					page.meta_description = attrs[:meta_description][locale]
					page.content = attrs[:content][locale]
				end
			end

			page.save!
			puts "Dibuat '#{page.title}' sebagai DRAFT (slug: #{page.slug})."
		end

		puts "Selesai. Isi teksnya lewat admin, lalu ubah status ke Published agar muncul di footer."
	end

	desc "Jalankan seluruh setup SEO Bulan 1"
	task setup: %i[seed_company_profile legal_pages]
end
