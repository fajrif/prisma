class Article < ApplicationRecord
	include ContentModified
	extend Mobility
  translates :title, :short_description, :meta_title, :meta_description

	extend FriendlyId
  friendly_id :title, use: :slugged

	include PublishedExtension
	include HasSeoSetting

	translates :content, backend: :action_text

	default_scope { order(published_date: :desc) }

	has_one_attached :image, dependent: :purge
	has_one_attached :file, dependent: :purge
	has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record
	belongs_to :category

	# => File
	validates :file, content_type: ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/msword'],
										size: { less_than: 50.megabytes, message: 'File maximum 50MB' }

  validates :image, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates_presence_of :title
	validates_uniqueness_of :title
	validate :modified_date_after_published_date

	def should_generate_new_friendly_id?
		self.title_changed?
	end

	LOCALE_ORDER = %i[en id cn].freeze

	# Bahasa yang artikel ini punya isinya SENDIRI. Satu-satunya sumber aturan; dipakai sitemap
	# dan hreflang/canonical di <head>. Dibaca dari data mentah, BUKAN lewat Mobility: fallback
	# en<->id membuat setiap artikel tampak punya versi dua bahasa.
	# ID adalah bahasa utama (hasil migrasi WordPress): cukup ada title. EN/CN wajib punya
	# title dan isi sendiri. `content_locales` (locale yang punya body) boleh diberikan agar
	# pemanggil massal (sitemap) tidak query per artikel.
	def own_locales(content_locales = nil)
		content_locales ||= ActionText::RichText.where(record_type: 'Article', record_id: id, name: 'content')
		                                         .where.not(body: [nil, ''])
		                                         .pluck(:locale).map(&:to_s)
		titles = read_attribute(:title) || {}
		LOCALE_ORDER.select do |l|
			has_title = titles[l.to_s].to_s.strip.present?
			l == :id ? has_title : has_title && content_locales.include?(l.to_s)
		end
	end

	def self.most_recent_articles(id, limit)
		where("id <> ?", id).limit(limit)
	end

	def private?
		false
	end

	def read_only?
		false
	end

	# Tanggal konten untuk lastmod, dateModified, dan label "Diperbarui". Memakai tanggal yang
	# diatur admin, bukan updated_at: simpan ulang untuk merapikan tampilan tidak dihitung
	# sebagai pembaruan. Tanpa modified_date nilainya = tanggal terbit.
	def content_modified_at
		[published_date, modified_date].compact.max || created_at
	end

	private

	def modified_date_after_published_date
		return if modified_date.blank? || published_date.blank?
		return if modified_date >= published_date

		errors.add(:modified_date, 'tidak boleh sebelum tanggal terbit')
	end
end
