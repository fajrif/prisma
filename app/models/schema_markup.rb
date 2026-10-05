class SchemaMarkup < ApplicationRecord
	extend Mobility
	translates :body

	# global => dipasang di semua halaman
	# record => dipasang pada satu record (polymorphic)
	# path   => dipasang pada URL yang cocok dengan path_pattern, contoh "/services/*"
	enum :scope_type, { global: 0, record: 1, path: 2 }, default: :global, prefix: :scope

	enum :status, { draft: 0, active: 1 }, default: :active, prefix: true

	belongs_to :schemable, polymorphic: true, optional: true

	default_scope { order(order_no: :asc, id: :asc) }

	validates_presence_of :name, :schema_type
	validates_uniqueness_of :name

	validate :body_must_be_valid_json
	validate :target_must_be_present

	def self.matching(record: nil, path: nil)
		status_active.select { |markup| markup.applies_to?(record: record, path: path) }
	end

	# Locale prefix dibuang supaya satu aturan berlaku untuk /en, /id, dan /cn
	def self.normalize_path(path)
		cleaned = path.to_s.sub(%r{\A/(id|cn)(?=/|\z)}, '')
		cleaned = cleaned.chomp('/')
		cleaned.presence || '/'
	end

	def applies_to?(record: nil, path: nil)
		case scope_type
		when 'global' then true
		when 'record' then matches_record?(record)
		when 'path' then matches_path?(path)
		else false
		end
	end

	def parsed_body(locale = I18n.locale)
		raw = Mobility.with_locale(locale) { body }
		return if raw.blank?

		JSON.parse(raw)
	rescue JSON::ParserError
		nil
	end

	def pretty_body(locale = I18n.locale)
		parsed = parsed_body(locale)
		parsed ? JSON.pretty_generate(parsed) : Mobility.with_locale(locale) { body }
	end

	def target_label
		case scope_type
		when 'global' then 'All pages'
		when 'record' then schemable ? "#{schemable_type} ##{schemable_id}" : "#{schemable_type} (missing)"
		when 'path' then path_pattern
		end
	end

	private

	def matches_record?(record)
		return false if record.blank? || schemable_type.blank?

		schemable_type == record.class.name && schemable_id == record.id
	end

	def matches_path?(path)
		return false if path_pattern.blank? || path.blank?

		File.fnmatch?(path_pattern, self.class.normalize_path(path), File::FNM_PATHNAME)
	end

	def target_must_be_present
		case scope_type
		when 'record'
			errors.add(:schemable_id, "must be selected for record scope") if schemable_id.blank?
		when 'path'
			errors.add(:path_pattern, "must be filled for path scope, e.g. /services/*") if path_pattern.blank?
		end
	end

	def body_must_be_valid_json
		raw = body
		return errors.add(:body, "can't be blank") if raw.blank?

		parsed = JSON.parse(raw)

		case parsed
		when Hash then validate_schema_object(parsed)
		when Array
			return errors.add(:body, "can't be an empty list") if parsed.empty?

			parsed.each { |item| validate_schema_object(item) }
		else
			errors.add(:body, "must be a JSON object or a list of JSON objects")
		end
	rescue JSON::ParserError => e
		errors.add(:body, "is not valid JSON (#{e.message.truncate(120)})")
	end

	def validate_schema_object(object)
		return errors.add(:body, "must be a JSON object") unless object.is_a?(Hash)

		errors.add(:body, 'is missing "@context" (e.g. "https://schema.org")') if object['@context'].blank?
		errors.add(:body, 'is missing "@type"') if object['@type'].blank? && object['@graph'].blank?
	end
end
