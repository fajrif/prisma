module StructuredData
	class Article < Base
		def initialize(record:, url: nil)
			@record = record
			@url = url
		end

		def payload
			return if @record.blank?

			compact_deep(
				'@type' => 'BlogPosting',
				'@id' => "#{@url}#article",
				'headline' => plain_text(@record.title, limit: 110),
				'description' => description,
				'image' => attachment_url(@record.image),
				'datePublished' => jakarta_time(@record.published_date),
				'dateModified' => jakarta_time(@record.content_modified_at), # sama dengan lastmod di sitemap
				'inLanguage' => locale_code,
				'articleSection' => plain_text(@record.category&.name),
				# Penulis per artikel menyusul pada Bulan 2 (halaman Author)
				'author' => organization_ref,
				'publisher' => organization_ref,
				'isPartOf' => { '@id' => website_id },
				'mainEntityOfPage' => { '@type' => 'WebPage', '@id' => @url }
			)
		end

		private

		# Spec meminta ISO 8601 dengan offset +07:00. `config.time_zone` aplikasi masih
		# default UTC, jadi konversi dilakukan di sini saja — mengubah timezone aplikasi
		# akan menggeser semua tanggal yang sudah tampil di halaman.
		def jakarta_time(value)
			value&.in_time_zone('Asia/Jakarta')&.iso8601
		end

		def description
			plain_text(seo_description.presence || @record.short_description, limit: 300)
		end
	end
end
