# Menerima laporan pelanggaran Content-Security-Policy selama mode report-only.
# Laporan hanya dicatat ke log; tidak ada efek apa pun ke pengunjung.
class CspReportsController < ActionController::Base
	skip_forgery_protection

	def create
		payload = request.body.read
		report = JSON.parse(payload)['csp-report'] || {}

		Rails.logger.warn(
			"[CSP] blocked=#{report['blocked-uri']} directive=#{report['effective-directive'] || report['violated-directive']} " \
			"document=#{report['document-uri']}"
		)
	rescue JSON::ParserError
		Rails.logger.warn("[CSP] unparseable report: #{payload.to_s.truncate(500)}")
	ensure
		head :no_content
	end
end
