module StructuredData
	# FAQPage dari blok FAQ yang benar-benar tampil di halaman (pages/_faq mendaftarkannya).
	# Isi schema wajib sama dengan yang terlihat; butir yang jawabannya masih "[TBC" dilewati.
	#
	# Teks jawaban di schema hanya boleh memuat HTML yang dikenal Google (h1-h6, br, ol, ul, li,
	# a, p, div, b, strong, i, em). Tag tabel tidak termasuk dan selnya akan menempel sebagai teks,
	# jadi tabel diubah menjadi daftar khusus di schema; tampilan halaman tetap tabel.
	class FaqPage < Base
		PLACEHOLDER = ::FaqItem::PLACEHOLDER
		ALLOWED_TAGS = %w[h1 h2 h3 h4 h5 h6 br ol ul li a p div b strong i em].freeze
		ALLOWED_ATTRIBUTES = %w[href].freeze

		# items: [[pertanyaan, jawaban HTML yang sudah disanitasi], ...]
		def initialize(items:, url:)
			@items = items
			@url = url
		end

		def payload
			entities = @items.filter_map do |question, answer|
				q = question.to_s.squish
				a = schema_answer(answer)
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

		# Dipakai juga oleh tampilan pratinjau schema di admin.
		def self.schema_answer(html)
			new(items: [], url: '').send(:schema_answer, html)
		end

		private

		# 1) tabel -> daftar, 2) buang tag yang tidak dikenal Google (u, dll) dengan menjaga teksnya.
		def schema_answer(html)
			fragment = Nokogiri::HTML5.fragment(html.to_s)
			fragment.css(ContentBlocksHelper::STRIPPED_WITH_CONTENT).each(&:remove) # isi script/style tidak boleh bocor jadi teks
			fragment.css('table').each { |table| table.replace(table_to_list(table)) }
			ActionController::Base.helpers.sanitize(fragment.to_html, tags: ALLOWED_TAGS, attributes: ALLOWED_ATTRIBUTES).to_s.strip
		end

		# Dengan header: <li>Header: nilai; Header: nilai</li>, satu <li> per baris data.
		# Tanpa header: sel digabung dengan " - ". Caption jadi paragraf sebelum daftar.
		def table_to_list(table)
			headers = table.css('thead th, thead td').map { |c| c.text.squish }
			rows = table.css('tr').reject { |tr| tr.ancestors('thead').any? }
			if headers.empty? && rows.first && rows.first.css('th').any? && rows.first.css('td').empty?
				headers = rows.shift.css('th').map { |c| c.text.squish }
			end

			items = rows.filter_map do |tr|
				cells = tr.css('th, td').map { |c| c.text.squish }
				next if cells.all?(&:blank?)

				text = if headers.size == cells.size && headers.any?(&:present?)
					cells.zip(headers).map { |value, head| head.present? ? "#{head}: #{value}" : value }.join('; ')
				else
					cells.reject(&:blank?).join(' - ')
				end
				"<li>#{ERB::Util.html_escape(text)}</li>"
			end

			caption = table.at_css('caption')&.text&.squish
			"#{"<p>#{ERB::Util.html_escape(caption)}</p>" if caption.present?}<ul>#{items.join}</ul>"
		end

		def plain(html)
			ActionController::Base.helpers.strip_tags(html).squish
		end
	end
end
