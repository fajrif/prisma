# Be sure to restart your server when you modify this file.
#
# Content Security Policy — MODE REPORT-ONLY (Roadmap Bulan 1).
#
# Pada mode ini browser TIDAK memblokir apa pun; pelanggaran hanya dilaporkan ke
# /csp-violation-report dan dicatat di log aplikasi. Data tersebut dipakai untuk
# menyusun policy final sebelum CSP benar-benar diberlakukan pada Bulan 2.
#
# Referensi direktif Google Maps:
#   https://developers.google.com/maps/documentation/javascript/content-security-policy
# Referensi Google Tag Manager:
#   https://developers.google.com/tag-platform/security/guides/csp
#
# Catatan: daftar domain di bawah belum tentu lengkap karena tag di dalam container
# GTM (GA4, Google Ads, Meta Pixel, dsb.) tidak terlihat dari kode aplikasi.
Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https

    policy.script_src  :self, :https, :unsafe_eval, :blob,
                       'https://www.googletagmanager.com',
                       'https://www.google-analytics.com',
                       'https://maps.googleapis.com',
                       'https://www.google.com',
                       'https://www.gstatic.com',
                       'https://cdnjs.cloudflare.com'

    policy.style_src   :self, :https, :unsafe_inline,
                       'https://fonts.googleapis.com',
                       'https://cdnjs.cloudflare.com'

    policy.img_src     :self, :data, :blob, :https,
                       'https://*.googleapis.com',
                       'https://*.gstatic.com',
                       'https://*.google.com',
                       'https://*.googleusercontent.com'

    policy.font_src    :self, :data,
                       'https://fonts.gstatic.com',
                       'https://cdnjs.cloudflare.com'

    policy.connect_src :self,
                       'https://*.googleapis.com',
                       'https://*.google.com',
                       'https://*.gstatic.com',
                       'https://*.google-analytics.com',
                       'https://*.analytics.google.com',
                       'https://*.googletagmanager.com',
                       :data, :blob

    policy.frame_src   :self,
                       'https://*.google.com',
                       'https://www.googletagmanager.com',
                       'https://www.youtube.com',
                       'https://www.youtube-nocookie.com'

    policy.worker_src  :self, :blob
    policy.object_src  :none
    policy.base_uri    :self

    policy.report_uri "/csp-violation-report"
  end

  # Nonce disiapkan sejak sekarang supaya script inline bisa dipasangi nonce
  # sebelum CSP diberlakukan pada Bulan 2.
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src]

  # JANGAN diubah ke false sebelum laporan pelanggaran bersih (lihat Roadmap Bulan 2).
  config.content_security_policy_report_only = true
end
