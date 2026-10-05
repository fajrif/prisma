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
				'datePublished' => @record.published_date&.iso8601,
				'dateModified' => (@record.updated_at || @record.published_date)&.iso8601,
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

		def description
			plain_text(@record.meta_description.presence || @record.short_description, limit: 300)
		end
	end
end
