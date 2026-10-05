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
