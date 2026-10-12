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
				'name' => Organization.facts['name'].presence || configatron.site_name,
				# Satu nama alternatif saja (keputusan strategist); "PT Prisma Harapan" hanya
				# berada di Organization.legalName.
				'alternateName' => 'Prisma Ads',
				'description' => plain_text(@setting.description.presence || configatron.site_description, limit: 300),
				'inLanguage' => %w[en id zh-Hans],
				'publisher' => organization_ref
			)
		end
	end
end
