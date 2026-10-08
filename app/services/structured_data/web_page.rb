module StructuredData
	# AboutPage / ContactPage (prisma-schema-spec.md bagian 8).
	#
	# Dipakai untuk halaman yang membicarakan entitas perusahaan itu sendiri,
	# sehingga `about` menunjuk ke @id Organization.
	class WebPage < Base
		TYPES = { 'about-us' => 'AboutPage', 'contact-us' => 'ContactPage' }.freeze

		def initialize(type:, url:)
			@type = type
			@url = url
		end

		# Mengembalikan nil kalau path-nya bukan About atau Contact.
		def self.for_path(path:, url:)
			key = path.to_s.delete_prefix('/')
			type = TYPES[key]
			return if type.blank?

			new(type: type, url: url).payload
		end

		def payload
			compact_deep(
				'@type' => @type,
				'@id' => "#{@url}#webpage",
				'url' => @url,
				'about' => organization_ref,
				'isPartOf' => { '@id' => website_id }
			)
		end
	end
end
