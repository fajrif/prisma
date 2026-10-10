class FaqItem < ApplicationRecord
	extend Mobility
	translates :question, :answer

	PUBLISHED = 1

	default_scope { order(order_no: :asc, id: :asc) }

	belongs_to :snippet

	before_validation :init_order_no

	scope :published, -> { where(status: PUBLISHED) }

	def published?
		status == PUBLISHED
	end

	PLACEHOLDER = '[TBC'.freeze

	# Butir hanya tampil di bahasa yang punya pertanyaan & jawabannya sendiri, dan yang tidak lagi
	# berisi placeholder "[TBC" dari strategist (placeholder tidak boleh terlihat publik maupun di schema).
	# fallback: false: tanpa itu halaman EN menampilkan teks ID (fallback en<->id).
	def filled_in?(locale = I18n.locale)
		Mobility.with_locale(locale) do
			q = question(fallback: false).to_s.strip
			a = ActionController::Base.helpers.strip_tags(answer(fallback: false).to_s).strip
			q.present? && a.present? && !q.include?(PLACEHOLDER) && !a.include?(PLACEHOLDER)
		end
	end

	def placeholder?(locale = I18n.locale)
		Mobility.with_locale(locale) { "#{question(fallback: false)} #{answer(fallback: false)}".include?(PLACEHOLDER) }
	end

	def filled_locales
		%i[en id cn].select { |l| filled_in?(l) }
	end

	private

	def init_order_no
		self.order_no = snippet.faq_items.where.not(id: id).count + 1 if order_no.to_i.zero? && snippet
	end
end
