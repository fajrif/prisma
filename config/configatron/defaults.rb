# Put all your default configatron settings here.

# Example:
#   configatron.emails.welcome.subject = 'Welcome!'
#   configatron.emails.sales_reciept.subject = 'Thanks for your order'
#
#   configatron.file.storage = :s3
# URL kanonik situs. Sumber tunggal untuk canonical, hreflang, dan seluruh @id schema.
configatron.site_url = "https://prisma-ads.com"
configatron.site_name = "prisma-ads.com"
configatron.site_title = "Prisma Advertising OOH Indonesia | Innovative Outdoor Ads"
configatron.site_description = "Prisma Advertising adalah perusahaan OOH indonesia yang akan memaksimalkan dampak merek anda dengan billboard Jakarta, videotron Jakarta, dll"

# Social Media
configatron.social_facebook_url = "https://www.facebook.com/prismaadvert"
configatron.social_linkedin_url = "https://www.linkedin.com/company/prismaadvertising"
configatron.social_instagram_url = "https://www.instagram.com/prisma.advertising/"
configatron.social_twitter_url = "https://twitter.com/PrismaAdvert"
configatron.social_youtube_url = "https://www.youtube.com/channel/UCg0kpAkiDh4C2PjinfobRkw"
configatron.social_tiktok_url = "https://www.tiktok.com/@prisma.advertising"

configatron.default_banner = "banners/banner.webp"
configatron.company_address = "GRHA PRISMA<br/>Jl. Kedoya Duri Raya No.38<br/>Kedoya Selatan<br/>Jakarta Barat 11520<br/>Indonesia"
configatron.admin_email = "info@prisma-ads.com"
configatron.no_reply_email = "no-reply@prisma-ads.com"
configatron.info_email = "info@prisma-ads.com"
configatron.sales_email = "sales@prisma-ads.com"
configatron.hrd_email = "hrd.recruitment@prisma-ads.com"
configatron.marketing_email = "marketing@prisma-ads.com"
configatron.whatsapp_number = "628111306888"
configatron.whatsapp_no_text = "+62 811 1306 888 (WA)"

configatron.email_name = "Prisma Advertising"
configatron.hrd_name = "HRD Recruitment Prisma Ads"
configatron.marketing_name = "Marketing Agent Prisma Ads"
configatron.sales_name = "Sales Team Prisma Ads"

configatron.company_phone1 = "+62 21 5835 6575 (Hunting)"
configatron.company_phone1 = "+62 21 5835 6570"

# Site key bersifat publik (memang tampil di HTML), secret key TIDAK boleh ada di repo.
# Nilai fallback yang dulu ditulis di sini sudah terlanjur masuk git history sejak
# commit 12e2abf, jadi keempat key lama harus dianggap bocor dan wajib diganti.
#
# SUMBER ENV:
#   production  -> ~/.profile user deployer (systemd menjalankan ExecStart via `bash -lc`)
#   development -> .env lewat dotenv-rails
# Keterangan lengkap ada di .env.example.
#
# ROTASI (Week 1, BELUM selesai):
#   1. Buat key pair BARU di https://www.google.com/recaptcha/admin. Tidak ada cara
#      meregenerasi secret saja — secret terikat pada site key-nya — jadi keempat
#      nilai ikut berubah, bukan hanya yang secret.
#   2. Set keempatnya di ~/.profile (pakai `export`) dan di .env lokal.
#   3. `systemctl restart unicorn-prisma`; reload/USR2 tidak mengambil ENV baru.
#      Lalu uji form inquiry dan form lamaran kerja.
#   4. Hapus key lama di console Google — ini yang benar-benar mematikan key bocor.
recaptcha_env = lambda do |name|
	value = ENV[name].to_s
	next value if value.present?

	# Production sengaja gagal keras saat boot: form yang diam-diam lolos tanpa
	# verifikasi jauh lebih sulit terdeteksi daripada aplikasi yang tidak mau start.
	raise KeyError, "ENV #{name} belum diset — set di ~/.profile (production) atau .env (development)" if Rails.env.production?

	Rails.logger.warn("[config] #{name} belum diset; reCAPTCHA tidak akan terverifikasi") if defined?(Rails.logger)
	''
end

configatron.recaptcha_v3_site_key = recaptcha_env.call('RECAPTCHA_V3_SITE_KEY')
configatron.recaptcha_v2_site_key = recaptcha_env.call('RECAPTCHA_V2_SITE_KEY')
configatron.recaptcha_v3_secret_key = recaptcha_env.call('RECAPTCHA_V3_SECRET_KEY')
configatron.recaptcha_v2_secret_key = recaptcha_env.call('RECAPTCHA_V2_SECRET_KEY')
