module StructuredData
	# Identitas resmi perusahaan. Data diambil dari Company Profile (tabel settings),
	# dengan fallback ke config/configatron/defaults.rb bila kolomnya belum diisi.
	class Organization < Base
		def initialize(setting: nil, address: nil)
			@setting = setting || ::Setting.current
			@address = address || ::Address.primary
		end

		def payload
			compact_deep(
				'@type' => 'Organization',
				'@id' => organization_id,
				'name' => name,
				'alternateName' => @setting.alternate_name.presence,
				'url' => base_url,
				'logo' => logo_url,
				'image' => logo_url,
				'description' => description,
				'email' => @setting.email.presence || configatron.info_email,
				'telephone' => @setting.phone.presence || configatron.company_phone1,
				'foundingDate' => @setting.founding_date&.iso8601,
				'address' => address_payload,
				'contactPoint' => contact_points,
				'sameAs' => same_as
			)
		end

		private

		def name
			@setting.legal_name.presence || configatron.email_name
		end

		def description
			plain_text(@setting.description.presence || configatron.site_description, limit: 500)
		end

		def logo_url
			attachment_url(@setting.logo) || absolute_url(ActionController::Base.helpers.image_path('logo-prisma.png'))
		rescue StandardError
			nil
		end

		def address_payload
			return @address.postal_address_schema if @address&.structured_address?
			return if @address.blank?

			{
				'@type' => 'PostalAddress',
				'streetAddress' => plain_text(@address.complete_address),
				'addressCountry' => 'ID'
			}.compact
		end

		def contact_points
			points = []

			sales_phone = @setting.phone.presence || configatron.company_phone1
			if sales_phone.present?
				points << {
					'@type' => 'ContactPoint',
					'contactType' => 'sales',
					'telephone' => sales_phone,
					'email' => configatron.sales_email,
					'areaServed' => 'ID',
					'availableLanguage' => %w[en id zh-Hans]
				}
			end

			whatsapp = @setting.whatsapp.presence || configatron.whatsapp_number
			if whatsapp.present?
				points << {
					'@type' => 'ContactPoint',
					'contactType' => 'customer support',
					'telephone' => "+#{whatsapp.to_s.delete_prefix('+')}",
					'areaServed' => 'ID',
					'availableLanguage' => %w[en id]
				}
			end

			points
		end

		def same_as
			urls = @setting.same_as_list
			return urls if urls.any?

			[
				configatron.social_facebook_url,
				configatron.social_linkedin_url,
				configatron.social_instagram_url,
				configatron.social_twitter_url,
				configatron.social_youtube_url,
				configatron.social_tiktok_url
			].compact_blank
		end
	end
end
