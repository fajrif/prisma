module StructuredData
	# Satu entri per kantor yang terdaftar di menu Addresses.
	class LocalBusiness < Base
		def self.all
			::Address.all.map { |address| new(address: address).payload }.compact_blank
		end

		def initialize(address:)
			@address = address
		end

		def payload
			return if @address.blank?

			compact_deep(
				'@type' => 'LocalBusiness',
				'@id' => "#{base_url}/#office-#{@address.id}",
				'name' => office_name,
				'parentOrganization' => organization_ref,
				'url' => base_url,
				'telephone' => @address.phone1.presence || @address.phone2.presence,
				'email' => @address.email1.presence || @address.email2.presence,
				'address' => address_payload,
				'geo' => geo_payload
			)
		end

		private

		def office_name
			company = ::Setting.current.company_name
			office = plain_text(@address.name)
			office.present? ? "#{company} — #{office}" : company
		end

		def address_payload
			@address.postal_address_schema || {
				'@type' => 'PostalAddress',
				'streetAddress' => plain_text(@address.complete_address),
				'addressCountry' => @address.country_code.presence || 'ID'
			}.compact
		end

		def geo_payload
			return if @address.latitude.blank? || @address.longitude.blank?

			{
				'@type' => 'GeoCoordinates',
				'latitude' => @address.latitude,
				'longitude' => @address.longitude
			}
		end
	end
end
