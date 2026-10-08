module StructuredData
	# Halaman titik billboard (schema.org/Place), 86 halaman.
	# Pemetaan field mengikuti prisma-schema-spec.md bagian 4.
	class Place < Base
		def initialize(record:, url:)
			@record = record
			@url = url
		end

		def payload
			return if @record.blank?

			compact_deep(
				'@type' => 'Place',
				'@id' => "#{@url}#place",
				'name' => name,
				'description' => description,
				'url' => @url,
				'image' => attachment_url(@record.image),
				'address' => address_payload,
				'geo' => geo_payload,
				'containedInPlace' => contained_in_place,
				'additionalProperty' => additional_properties,
				'publicAccess' => true
			)
		end

		private

		# Spec: beri awalan "Billboard " kecuali namanya sudah menyebut LED.
		def name
			raw = plain_text(@record.name)
			return if raw.blank?
			return raw if raw.match?(/\bLED\b/i)

			raw.match?(/\bbillboard\b/i) ? raw : "Billboard #{raw}"
		end

		def description
			plain_text(@record.description, limit: 300)
		end

		def address_payload
			{
				'@type' => 'PostalAddress',
				'streetAddress' => plain_text(@record.address),
				'addressLocality' => @record.city.presence,
				'addressRegion' => @record.region.presence,
				'addressCountry' => 'ID'
			}.compact
		end

		# Kolom lat/long bertipe string; schema.org mengharapkan angka.
		def geo_payload
			lat = Float(@record.latitude, exception: false)
			lng = Float(@record.longitude, exception: false)
			return if lat.nil? || lng.nil?

			{ '@type' => 'GeoCoordinates', 'latitude' => lat, 'longitude' => lng }
		end

		def contained_in_place
			city = @record.city.presence
			return if city.blank?

			{ '@type' => 'City', 'name' => city }
		end

		# Nama properti mengikuti bahasa halaman. Properti yang datanya kosong
		# tidak diemit sama sekali (aturan di bagian 0 spec).
		def additional_properties
			[
				property(:format, format_label),
				property(:size, @record.size.presence),
				property(:orientation, orientation_label),
				property(:lighting, @record.lighting.presence),
				property(:slot_duration, @record.slot_duration.presence),
				property(:operating_hours, @record.operating_hours.presence),
				property(:impressions_per_day, @record.impressions_per_day),
				property(:points_of_interest, @record.interest.presence)
			].compact
		end

		def property(key, value)
			return if value.blank?

			{ '@type' => 'PropertyValue', 'name' => I18n.t("schema.place.#{key}"), 'value' => value }
		end

		# Format diturunkan dari enum billboard_type, bukan kolom terpisah.
		def format_label
			@record.billboard_type_label
		end

		# Orientasi diturunkan dari nama kategori produk ("Horizontal LED",
		# "Vertical Static Billboard", "Curved Horizontal LED", ...).
		def orientation_label
			category = @record.product_category&.name.to_s
			return if category.blank?

			match = category.match(/\b(curved\s+)?(horizontal|vertical|square)\b/i)
			match && match[0].split.map(&:capitalize).join(' ')
		end
	end
end
