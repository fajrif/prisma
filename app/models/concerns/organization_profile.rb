# Fakta schema Organization yang bisa diedit tim SEO dari Company Profile.
#
# Nilai tersimpan di kolom `settings` (satu-satunya sumber; tidak ada file konfigurasi
# cadangan). Semua daftar diedit sebagai teks, satu item per baris, lalu diparse ke JSONB. Teks yang salah format ditolak saat validasi (tidak
# diam-diam dibuang) dan tampil kembali apa adanya di form.
module OrganizationProfile
  extend ActiveSupport::Concern

  PHONE_FORMAT = /\A\+\d{1,3}(?:[- ]?\d){6,14}\z/
  HTTPS_URL = %r{\Ahttps://[^\s/]+\.[^\s/]+\S*\z}
  LANGUAGE_FORMAT = /\A[a-z]{2,3}(?:-[A-Za-z]{2,4})?\z/

  included do
    validates :founding_year, format: { with: /\A\d{4}\z/, message: 'harus empat digit, mis. 2004' }, allow_blank: true
    validate :organization_profile_text_must_be_valid
    # Identitas resmi wajib terisi saat diubah lewat langkah konfirmasi (context :identity).
    validates :brand_name, :legal_name, :founding_year, presence: true, on: :identity
  end

  # Nilai tersimpan untuk kolom profil (mis. `profile(:alternate_names)`).
  def profile(attr)
    self[attr]
  end

  def alternate_names_text = text_for(:alternate_names) { |v| v }
  def knows_about_text = text_for(:knows_about) { |v| v }

  def area_served_text
    text_for(:area_served) { |a| "#{a['type']}: #{a['name']}" }
  end

  def contact_points_text
    text_for(:contact_points) do |c|
      [c['contact_type'], c['telephone'], c['email'], c['area_served'], Array(c['available_language']).join(',')].join(' | ')
    end
  end

  def sub_organizations_text
    text_for(:sub_organizations) { |o| [o['id'], o['name'], o['url']].join(' | ') }
  end

  def alternate_names_text=(text)
    assign_lines(:alternate_names, text) { |line| line }
  end

  def knows_about_text=(text)
    assign_lines(:knows_about, text) { |line| line }
  end

  def area_served_text=(text)
    assign_lines(:area_served, text) do |line|
      type, name = line.split(':', 2).map(&:strip)
      unless Service::AREA_TYPES.include?(type) && name.present?
        next profile_error(:area_served_text, "baris tidak valid: \"#{line}\". Gunakan \"Tipe: Nama\" dengan tipe #{Service::AREA_TYPES.join(', ')}")
      end

      { 'type' => type, 'name' => name }
    end
  end

  def contact_points_text=(text)
    assign_lines(:contact_points, text) do |line|
      type, phone, email, area, langs = line.split('|', 5).map(&:strip)
      problem =
        if type.blank? then 'jenis kontak kosong'
        elsif phone !~ PHONE_FORMAT then 'telepon harus format internasional, mis. +62-21-5835-6575'
        elsif email.present? && email !~ URI::MailTo::EMAIL_REGEXP then 'email tidak valid'
        elsif area.present? && area !~ /\A[A-Z]{2}\z/ then 'area harus kode negara dua huruf, mis. ID'
        elsif Array(langs.to_s.split(',')).map(&:strip).any? { |l| l !~ LANGUAGE_FORMAT } then 'bahasa harus kode seperti id,en'
        end
      next profile_error(:contact_points_text, "baris tidak valid: \"#{line}\" (#{problem}). Format: jenis | telepon | email | area | bahasa") if problem

      { 'contact_type' => type, 'telephone' => phone, 'email' => email.presence, 'area_served' => area.presence,
        'available_language' => langs.to_s.split(',').map(&:strip).reject(&:blank?) }.compact
    end
  end

  def sub_organizations_text=(text)
    assign_lines(:sub_organizations, text) do |line|
      id, name, url = line.split('|', 3).map(&:strip)
      unless id =~ HTTPS_URL && url =~ HTTPS_URL && name.present?
        next profile_error(:sub_organizations_text, "baris tidak valid: \"#{line}\". Format: @id (https) | nama | url (https)")
      end

      { 'id' => id, 'name' => name, 'url' => url }
    end
  end

  private

  def profile_errors
    @profile_errors ||= []
  end

  def raw_profile_text
    @raw_profile_text ||= {}
  end

  def profile_error(field, message)
    profile_errors << [field, message]
    nil
  end

  # Teks untuk form: input mentah (bila tadi gagal validasi), atau nilai tersimpan.
  def text_for(attr)
    return raw_profile_text[attr] if raw_profile_text.key?(attr)

    Array(profile(attr)).map { |item| yield(item) }.join("\n")
  end

  def assign_lines(attr, text)
    raw_profile_text[attr] = text.to_s
    items = text.to_s.lines.map(&:strip).reject(&:blank?).filter_map { |line| yield(line) }.uniq
    self[attr] = items
  end

  def organization_profile_text_must_be_valid
    profile_errors.each { |field, message| errors.add(field, message) }
  end
end
