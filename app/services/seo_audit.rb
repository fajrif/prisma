# Audit title & description tiap halaman: kosong/default situs, panjang di luar batas, duplikat
# (per bahasa). Memakai SeoMeta langsung (tanpa HTTP), jadi hasilnya sama dengan yang dirender
# layout. Dipakai rake `seo:audit` dan menu admin SEO -> SEO Audit; hasil admin disimpan sebagai
# JSON di tmp/seo_audit (10 run terakhir).
class SeoAudit
	LOCALES = %i[en id cn].freeze
	KEEP = 10
	DIR = Rails.root.join('tmp', 'seo_audit')
	FILE_RE = /\Aaudit-\d{8}-\d{6}\.json\z/

	ISSUES = {
		'title_default' => 'Title default situs', 'desc_default' => 'Description default situs',
		'title_short' => 'Title terlalu pendek', 'title_long' => 'Title terlalu panjang',
		'desc_short' => 'Description terlalu pendek', 'desc_long' => 'Description terlalu panjang',
		'title_dup' => 'Title ganda', 'desc_dup' => 'Description ganda'
	}.freeze

	class << self
		def run
			limits = { title: [SeoMeta::TITLE_MIN, SeoMeta::TITLE_LIMIT], description: [SeoMeta::DESCRIPTION_MIN, SeoMeta::DESCRIPTION_LIMIT] }
			rows = []
			findings = []

			LOCALES.each do |locale|
				I18n.with_locale(locale) do
					locale_rows = subjects.map { |s| build_row(s, locale, limits) }
					dup_findings = mark_duplicates(locale_rows)
					locale_rows.each do |r|
						r[:issues].reject { |i| i.end_with?('_dup') }.each { |i| findings << finding(locale, r, i, limits) }
					end
					findings.concat(dup_findings.map { |f| f.merge(locale: locale.to_s) })
					rows.concat(locale_rows)
				end
			end

			{ generated_at: Time.current.iso8601, limits: limits, rows: rows, findings: findings, summary: summary(rows, findings) }
		end

		def save(result)
			FileUtils.mkdir_p(DIR)
			name = "audit-#{Time.current.strftime('%Y%m%d-%H%M%S')}.json"
			json = JSON.pretty_generate(result)
			File.write(DIR.join(name), json)
			File.write(DIR.join('latest.json'), json)
			history.drop(KEEP).each { |n| File.delete(DIR.join(n)) }
			name
		end

		# Nama file run, terbaru dulu.
		def history
			return [] unless DIR.exist?

			Dir.children(DIR).grep(FILE_RE).sort.reverse
		end

		def load(name = nil)
			name = history.first if name.blank?
			return unless name && name.match?(FILE_RE) && File.exist?(DIR.join(name))

			JSON.parse(File.read(DIR.join(name)), symbolize_names: true).merge(file: name)
		end

		def path(name)
			DIR.join(name) if name.to_s.match?(FILE_RE) && File.exist?(DIR.join(name))
		end

		private

		# [label, record, opts]
		def subjects
			list = []
			list += Page.all.map { |r| ["page:#{r.slug}", r] }
			list += Article.where(status: 1).map { |r| ["article:#{r.slug}", r] }
			list += Service.all.map { |r| ["service:#{r.slug}", r] }
			list += Industry.all.map { |r| ["industry:#{r.slug}", r] }
			list += Portfolio.all.map { |r| ["portfolio:#{r.slug}", r] }
			list += Location.all.map { |r| ["location:#{r.slug}", r] }
			list += Product.unscoped.map { |r| ["billboard:#{r.slug}", r] }
			list += Career.all.map { |r| ["career:#{r.slug}", r] }
			%w[articles portfolios industries locations inquiries].each do |c|
				list << ["index:#{c}", nil, { controller: c, action: 'index' }]
			end
			list
		end

		def build_row((label, record, opts), locale, limits)
			meta = SeoMeta.new(record: record, controller: opts&.dig(:controller), action: opts&.dig(:action))
			title = meta.title.to_s
			desc = meta.description.to_s
			issues = []
			issues << 'title_default' if meta.title_source == :default
			issues << 'desc_default' if meta.description_source == :default
			issues << (title.length > limits[:title][1] ? 'title_long' : 'title_short') unless (limits[:title][0]..limits[:title][1]).cover?(title.length)
			issues << (desc.length > limits[:description][1] ? 'desc_long' : 'desc_short') unless (limits[:description][0]..limits[:description][1]).cover?(desc.length)
			type, = label.split(':', 2)
			{ locale: locale.to_s, type: type, label: label, record_type: record&.class&.name, record_id: record&.id,
				public_path: public_path(record, label, locale), title: title, title_len: title.length,
				title_source: meta.title_source.to_s, description: desc, description_len: desc.length,
				description_source: meta.description_source.to_s, issues: issues }
		end

		def public_path(record, label, locale)
			prefix = locale == :en ? '' : "/#{locale}"
			case record
			when Page then record.slug == 'home' ? (prefix.presence || '/') : "#{prefix}/#{record.slug}"
			when Article then "#{prefix}/articles/#{record.slug}"
			when Service then "#{prefix}/services/#{record.slug}"
			when Industry then "#{prefix}/industries/#{record.slug}"
			when Portfolio then "#{prefix}/campaigns/#{record.slug}"
			when Location then record.public_path(locale)
			when Area then record.public_path(locale)
			when Product then record.public_path(locale)
			when Career then "#{prefix}/careers/#{record.slug}"
			else
				name = label.split(':', 2).last
				"#{prefix}/#{{ 'portfolios' => 'campaigns', 'inquiries' => 'contact-us' }.fetch(name, name)}"
			end
		end

		# Menambah kode *_dup ke baris yang kembar; mengembalikan temuan per kelompok (format rake).
		def mark_duplicates(rows)
			out = []
			{ title: ['title', 'title_dup'], description: ['description', 'desc_dup'] }.each do |field, (name, code)|
				rows.group_by { |r| r[field] }.each do |text, group|
					next if group.size < 2

					group.each { |r| r[:issues] << code }
					out << { label: group.map { |g| g[:label] }.first(4).join(', ') + (group.size > 4 ? " (+#{group.size - 4})" : ''),
									 message: "#{name} ganda di #{group.size} halaman: #{text.truncate(60)}", code: code }
				end
			end
			out
		end

		def finding(locale, row, code, limits)
			msg = case code
			      when 'title_default' then 'title memakai default situs'
			      when 'desc_default' then 'description memakai default situs'
			      when 'title_short', 'title_long' then "title #{row[:title_len]} karakter (ideal #{limits[:title][0]}..#{limits[:title][1]})"
			      else "description #{row[:description_len]} karakter (ideal #{limits[:description][0]}..#{limits[:description][1]})"
			      end
			{ locale: locale.to_s, label: row[:label], message: msg, code: code }
		end

		def summary(rows, findings)
			{ pages: rows.group_by { |r| r[:locale] }.transform_values(&:size),
				findings: findings.group_by { |f| f[:locale] }.transform_values(&:size),
				by_issue: findings.group_by { |f| f[:code] }.transform_values(&:size) }
		end
	end
end
