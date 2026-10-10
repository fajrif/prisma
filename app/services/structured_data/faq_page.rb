module StructuredData
	# FAQPage dari blok FAQ yang benar-benar tampil di halaman (pages/_faq mendaftarkannya).
	# Isi schema wajib sama dengan yang terlihat; butir yang jawabannya masih "[TBC" dilewati.
	class FaqPage < Base
		PLACEHOLDER = ::FaqItem::PLACEHOLDER

		# items: [[pertanyaan, jawaban HTML yang sudah disanitasi], ...]
		def initialize(items:, url:)
			@items = items
			@url = url
		end

		def payload
			entities = @items.filter_map do |question, answer|
				q = question.to_s.squish
				a = answer.to_s.strip
				next if q.blank? || plain(a).blank? || q.include?(PLACEHOLDER) || plain(a).include?(PLACEHOLDER)

				{
					'@type' => 'Question',
					'name' => q,
					'acceptedAnswer' => { '@type' => 'Answer', 'text' => a }
				}
			end
			return if entities.empty?

			{
				'@type' => 'FAQPage',
				'@id' => "#{@url}#faq",
				'url' => @url,
				'inLanguage' => locale_code,
				'mainEntity' => entities
			}
		end

		private

		def plain(html)
			ActionController::Base.helpers.strip_tags(html).squish
		end
	end
end
