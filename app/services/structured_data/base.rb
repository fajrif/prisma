module StructuredData
	# Induk semua generator schema otomatis.
	# Tiap subclass mengembalikan satu Hash JSON-LD lewat #payload.
	class Base

		def self.call(...)
			new(...).payload
		end

		def payload
			raise NotImplementedError
		end

		protected

		def base_url
			configatron.site_url
		end

		def organization_id
			"#{base_url}/#organization"
		end

		def website_id
			"#{base_url}/#website"
		end

		def organization_ref
			{ '@id' => organization_id }
		end

		# Mengikuti pemetaan locale di SeoHelper#html_lang_code
		def locale_code(locale = I18n.locale)
			case locale.to_sym
			when :cn then 'zh-Hans'
			when :id then 'id'
			else 'en'
			end
		end

		def absolute_url(path)
			return if path.blank?
			return path if path.to_s.start_with?('http')

			"#{base_url}#{path.to_s.start_with?('/') ? path : "/#{path}"}"
		end

		def attachment_url(attachment)
			return if attachment.blank?
			return unless attachment.respond_to?(:attached?) && attachment.attached?

			url = Rails.application.routes.url_helpers.url_for(attachment)
			Rails.env.production? ? url.sub(%r{\Ahttps?://[^/]+}, base_url) : url
		rescue StandardError => e
			Rails.logger.warn("[StructuredData] cannot build attachment url: #{e.message}")
			nil
		end

		# Membersihkan HTML jadi teks biasa. <br> dan tag blok diganti pemisah
		# supaya kalimat tidak menempel (mis. alamat yang disimpan dengan <br/>).
		def plain_text(value, limit: nil)
			html = value.to_s
								 .gsub(%r{<br\s*/?>}i, ', ')
								 .gsub(%r{</(p|div|li|h[1-6]|tr)>}i, ' ')

			text = ActionView::Base.full_sanitizer.sanitize(html).to_s.squish
			text = text.gsub(/(?:,\s*){2,}/, ', ').sub(/[,\s]+\z/, '')
			return if text.blank?

			limit ? text.truncate(limit) : text
		end

		# Membuang key yang nilainya kosong supaya output JSON-LD bersih
		def compact_deep(value)
			case value
			when Hash
				value.each_with_object({}) do |(key, val), memo|
					cleaned = compact_deep(val)
					memo[key] = cleaned unless blank_value?(cleaned)
				end
			when Array
				value.map { |val| compact_deep(val) }.reject { |val| blank_value?(val) }
			else
				value
			end
		end

		private

		def blank_value?(value)
			return false if value == false

			value.nil? || (value.respond_to?(:empty?) && value.empty?)
		end
	end
end
