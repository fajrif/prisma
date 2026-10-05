class Setting < ApplicationRecord
	extend Mobility
	translates :description

	has_one_attached :logo, dependent: :purge

	validates :logo, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp', 'image/svg+xml'],
										size: { less_than: 10.megabytes, message: 'Image maximum 10MB' }

	# Profil perusahaan disimpan sebagai satu baris saja
	def self.current
		first || create!
	end

	def company_name
		legal_name.presence || configatron.email_name
	end

	def same_as_list
		Array(same_as).map { |url| url.to_s.strip }.reject(&:blank?)
	end

	# Textarea admin: satu URL per baris
	def same_as_text
		same_as_list.join("\n")
	end

	def same_as_text=(value)
		self.same_as = value.to_s.split(/\r?\n/).map(&:strip).reject(&:blank?)
	end

	def logo_url
		return unless logo.attached?

		Rails.application.routes.url_helpers.url_for(logo)
	end
end
