# Blok FAQ & tabel (T8): sanitasi isi dari TinyMCE, penempatan di konten non-Page,
# dan pengumpulan butir FAQ yang tampil untuk schema FAQPage.
module ContentBlocksHelper
	RICH_BLOCK_TAGS = %w[p br strong b em i u a ul ol li table caption thead tbody tfoot tr th td].freeze
	RICH_BLOCK_ATTRIBUTES = %w[href title target rel scope colspan rowspan].freeze
	STRIPPED_WITH_CONTENT = 'script, style, iframe, object, embed, noscript, template, svg, math'.freeze

	# Isi dari TinyMCE hanya boleh memuat markup teks & tabel; style inline, script, dan atribut
	# event dibuang di sini (bukan hanya di editor) karena isinya tersimpan apa adanya di DB.
	def rich_block_html(html)
		# sanitize membuang tag di luar allowlist tetapi mempertahankan teks di dalamnya, jadi isi
		# <script>/<style> akan bocor sebagai teks. Elemen semacam itu dibuang utuh lebih dulu.
		fragment = Loofah.html5_fragment(html.to_s)
		fragment.css(STRIPPED_WITH_CONTENT).each(&:remove)
		sanitize(fragment.to_s, tags: RICH_BLOCK_TAGS, attributes: RICH_BLOCK_ATTRIBUTES)
	end

	# Butir FAQ yang tampil sebagai pasangan [pertanyaan, jawaban HTML yang sudah disanitasi].
	# Diisi oleh pages/_faq; dibaca SeoHelper#render_structured_data. View dirender sebelum layout,
	# jadi daftar ini sudah lengkap saat <head> dibangun.
	def rendered_faq_items
		@rendered_faq_items ||= []
	end

	def register_faq_items(pairs)
		rendered_faq_items.concat(pairs)
	end

	# Butir yang layak tampil di bahasa aktif: published dan pertanyaan + jawabannya terisi sendiri.
	def visible_faq_items(snippet)
		snippet.faq_items.published.select(&:filled_in?)
	end

	# Blok konten (FAQ/tabel) yang dipasang pada Article, Location, Industry, Product.
	def render_content_blocks(record)
		return unless record.respond_to?(:content_blocks)

		blocks = record.content_blocks.visible.includes(:snippet).select { |b| ContentBlock::TEMPLATES.include?(b.snippet&.template) }
		return if blocks.empty?

		render 'shared/content_blocks', blocks: blocks
	end
end
