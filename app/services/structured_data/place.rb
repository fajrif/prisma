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

		# Spec bagian 4: kalimat yang sama dengan subtitle di halaman.
		def description
			plain_text(@record.subtitle, limit: 300)
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
				# Spec: pencahayaan hanya titik statis; durasi slot & jam tayang hanya LED.
				(property(:lighting, @record.lighting.presence) if @record.static?),
				(property(:slot_duration, @record.slot_duration.presence) if @record.digital?),
				(property(:operating_hours, @record.operating_hours.presence) if @record.digital?),
				property(:impressions_per_day, @record.impressions_per_day),
				property(:points_of_interest, @record.interest.presence)
			].compact
		end

		def property(key, value)
			return if value.blank?

			{ '@type' => 'PropertyValue', 'name' => I18n.t("schema.place.#{key}"), 'value' => value }
		end

		# Format diturunkan dari enum billboard_type, bukan kolom terpisah; label mengikuti bahasa halaman.
		def format_label
			@record.type_name
		end

		def orientation_label
			@record.orientation
		end
	end
end
