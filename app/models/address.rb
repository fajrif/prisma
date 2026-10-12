class Address < ApplicationRecord
	extend Mobility
  translates :name

	default_scope { order(order_no: :asc) }

	validates_presence_of :name, :complete_address
	validates_uniqueness_of :name

	# Kantor utama dipakai sebagai alamat resmi pada schema Organization
	def self.primary
		find_by(primary_office: true) || first
	end

	def structured_address?
		street_address.present? && locality.present?
	end

	# Alamat untuk tampilan (footer, Contact, Inquiry). Dirakit dari field terstruktur supaya
	# sama persis dengan PostalAddress di schema; `complete_address` hanya fallback.
	def display_address
		return complete_address unless structured_address?

		country = country_code.presence == 'ID' || country_code.blank? ? 'Indonesia' : country_code
		city_line = [locality, postal_code.presence].compact.join(' ')
		lines = [street_address, city_line, country].map { |line| ERB::Util.html_escape(line) }
		lines.join('<br/>').html_safe
	end

	def postal_address_schema
		return unless structured_address?

		{
			'@type' => 'PostalAddress',
			'streetAddress' => street_address,
			'addressLocality' => locality,
			'addressRegion' => region.presence,
			'postalCode' => postal_code.presence,
			'addressCountry' => country_code.presence || 'ID'
		}.compact
	end
end
