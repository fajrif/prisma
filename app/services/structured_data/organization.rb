module StructuredData
	# Identitas resmi perusahaan (schema.org/Organization).
	#
	# Sumber data:
	#   - Company Profile (tabel settings) yang diedit tim SEO: nama dagang, badan hukum,
	#     tahun berdiri, nama alternatif, area layanan, bidang keahlian, anak perusahaan,
	#     titik kontak, deskripsi, logo, sameAs, email, telepon.
	#   - Penghargaan dibaca dari CRUD Awards yang sudah ada.
	# Tidak ada file konfigurasi cadangan: kolom kosong berarti node itu tidak diemit.
	class Organization < Base
		EXCLUDED_SAME_AS_HOSTS = %w[facebook.com twitter.com x.com].freeze

		# Nama dagang; dipakai juga oleh WebSite supaya keduanya selalu sama.
		def self.brand_name(setting = ::Setting.current)
			setting.profile(:brand_name).presence || configatron.email_name
		end

		def initialize(setting: nil, address: nil)
			@setting = setting || ::Setting.current
			@address = address || ::Address.primary
		end

		def payload
			compact_deep(
				'@type' => 'Organization',
				'@id' => organization_id,
				'name' => name,
				'legalName' => legal_name,
				'alternateName' => alternate_names,
				'url' => "#{base_url}/",
				'logo' => logo_object,
				'image' => logo_url,
				'description' => description,
				'email' => @setting.email.presence || configatron.info_email,
				'telephone' => primary_telephone,
				'foundingDate' => founding_date,
				'address' => address_payload,
				'contactPoint' => contact_points,
				'areaServed' => area_served,
				'knowsAbout' => @setting.profile(:knows_about),
				'award' => awards,
				'subOrganization' => sub_organizations,
				'sameAs' => same_as
			)
		end

		private

		# Nama dagang yang dipakai publik; berbeda dari badan hukum.
		def name
			self.class.brand_name(@setting)
		end

		# Badan hukum. Tidak diemit kalau nilainya sama dengan nama dagang.
		def legal_name
			value = @setting.profile(:legal_name).presence
			value if value.present? && value != name
		end

		def alternate_names
			list = Array(@setting.profile(:alternate_names)).map { |v| v.to_s.strip }.reject(&:blank?)
			return list if list.any?

			Array(@setting.alternate_name.presence)
		end

		def description
			plain_text(@setting.description.presence || configatron.site_description, limit: 500)
		end

		def logo_url
			attachment_url(@setting.logo) || absolute_url(ActionController::Base.helpers.image_path('logo-prisma.png'))
		rescue StandardError
			nil
		end

		# Spec meminta logo berupa ImageObject, bukan string URL.
		def logo_object
			url = logo_url
			return if url.blank?

			{ '@type' => 'ImageObject', 'url' => url }
		end

		# Spec menulis "2004" (tahun saja), bukan tanggal penuh.
		def founding_date
			@setting.profile(:founding_year).presence || @setting.founding_date&.year&.to_s
		end

		# Telepon kontak pertama yang punya nomor (customer service boleh tanpa telepon).
		def primary_telephone
			from_points = Array(@setting.profile(:contact_points)).filter_map { |c| c['telephone'].presence }.first
			from_points || @setting.phone.presence
		end

		def address_payload
			return @address.postal_address_schema if @address&.structured_address?
			return if @address.blank?

			{
				'@type' => 'PostalAddress',
				'streetAddress' => plain_text(@address.complete_address),
				'addressCountry' => 'ID'
			}.compact
		end

		def contact_points
			Array(@setting.profile(:contact_points)).map do |point|
				{
					'@type' => 'ContactPoint',
					'contactType' => point['contact_type'],
					'telephone' => point['telephone'],
					'email' => point['email'],
					'areaServed' => point['area_served'],
					'availableLanguage' => point['available_language']
				}
			end
		end

		def area_served
			Array(@setting.profile(:area_served)).map do |area|
				{ '@type' => area['type'], 'name' => area['name'] }
			end
		end

		def sub_organizations
			Array(@setting.profile(:sub_organizations)).map do |org|
				{ '@type' => 'Organization', '@id' => org['id'], 'name' => org['name'], 'url' => org['url'] }
			end
		end

		# Dibaca dari CRUD Awards supaya tim SEO bisa menambah penghargaan sendiri.
		def awards
			::Award.all.map { |award| plain_text(award.schema_text.presence || award.name) }.compact_blank
		rescue StandardError => e
			Rails.logger.warn("[StructuredData] cannot read awards: #{e.message}")
			[]
		end

		def same_as
			# Keputusan strategist: hanya Instagram, LinkedIn, YouTube, TikTok. Facebook dan X
			# dibuang walau masih ada di Company Profile.
			urls = @setting.same_as_list.reject { |url| EXCLUDED_SAME_AS_HOSTS.any? { |host| url.match?(%r{//(?:[\w-]+\.)*#{Regexp.escape(host)}(?:/|\z)}i) } }
			return urls if urls.any?

			[configatron.social_instagram_url, configatron.social_linkedin_url,
			 configatron.social_youtube_url, configatron.social_tiktok_url].compact_blank
		end
	end
end
