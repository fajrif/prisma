module StructuredData
	class WebSite < Base
		def initialize(setting: nil)
			@setting = setting || ::Setting.current
		end

		def payload
			compact_deep(
				'@type' => 'WebSite',
				'@id' => website_id,
				'url' => base_url,
				# Nama merek, bukan nama badan hukum — harus sama dengan Organization.name
				# yang bertetangga di @graph yang sama (dulu memakai legal_name sehingga
				# satu entitas disebut dengan dua nama berbeda di satu halaman).
				'name' => Organization.brand_name(@setting),
				# Satu nama alternatif saja (keputusan strategist): yang pertama di daftar Company
				# Profile. "PT Prisma Harapan" hanya berada di Organization.legalName.
				'alternateName' => Array(@setting.profile(:alternate_names)).first.presence,
				'description' => plain_text(@setting.description.presence || configatron.site_description, limit: 300),
				'inLanguage' => %w[en id zh-Hans],
				'publisher' => organization_ref
			)
		end
	end
end
