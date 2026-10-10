# Menu SEO -> SEO Audit: menjalankan SeoAudit, menyimpan hasilnya (tmp/seo_audit) dan
# menampilkannya sebagai tabel dengan filter.
class Admins::SeoAuditsController < Admins::BaseController
	PER_PAGE = 50

	def show
		@history = SeoAudit.history
		@audit = SeoAudit.load(params[:run])
		return unless @audit

		rows = @audit[:rows]
		rows = rows.select { |r| r[:locale] == params[:audit_locale] } if params[:audit_locale].present?
		rows = rows.select { |r| r[:type] == params[:type] } if params[:type].present?
		case params[:issue]
		when 'any' then rows = rows.select { |r| r[:issues].any? }
		when *SeoAudit::ISSUES.keys then rows = rows.select { |r| r[:issues].include?(params[:issue]) }
		end
		if params[:q].present?
			q = params[:q].downcase
			rows = rows.select { |r| [r[:label], r[:title], r[:description]].any? { |t| t.to_s.downcase.include?(q) } }
		end
		@types = @audit[:rows].map { |r| r[:type] }.uniq
		@total_rows = rows.size
		@rows = Kaminari.paginate_array(rows).page(params[:page]).per(PER_PAGE)
	end

	def create
		name = SeoAudit.save(SeoAudit.run)
		redirect_to admins_seo_audit_path(run: name), notice: 'Audit SEO selesai dijalankan.'
	rescue StandardError => e
		Rails.logger.error("SeoAudit gagal: #{e.class}: #{e.message}")
		redirect_to admins_seo_audit_path, alert: "Audit gagal dijalankan: #{e.message}"
	end

	def download
		file = SeoAudit.path(params[:run].presence || SeoAudit.history.first)
		return redirect_to(admins_seo_audit_path, alert: 'File audit tidak ditemukan.') unless file

		send_file file, type: 'application/json', disposition: 'attachment'
	end
end
