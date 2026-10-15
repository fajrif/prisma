# Prefix bahasa untuk path publik: '' untuk bahasa default (en), '/id' atau '/cn' untuk lainnya.
module PublicPath
	def self.prefix(locale = I18n.locale)
		locale.to_sym == I18n.default_locale.to_sym ? '' : "/#{locale}"
	end
end
