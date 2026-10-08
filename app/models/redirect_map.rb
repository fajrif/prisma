# Pembaca config/redirects.yml.
#
# Dipisahkan dari controller supaya penambahan baris redirect dari SEO Strategist
# cukup mengedit berkas YAML, tanpa menyentuh kode.
class RedirectMap
  CONFIG_PATH = Rails.root.join('config', 'redirects.yml').freeze

  class << self
    # Slug halaman lama dinormalisasi: huruf kecil, tanpa "-" dan "_", tanpa slash.
    # Dibuat longgar karena URL WordPress lama ditulis tidak konsisten.
    def normalize_slug(slug)
      slug.to_s.downcase.delete('/').gsub(/[-_]/, '')
    end

    def legacy_page(slug)
      section('legacy_pages')[normalize_slug(slug)]
    end

    def article(slug)
      section('articles')[slug.to_s]
    end

    # Sebagian artikel hanya punya versi Indonesia; redirect-nya dipaksa ke /id
    # apa pun locale permintaannya.
    def article_locale(slug)
      section('articles_force_locale')[slug.to_s]
    end

    def service(slug)
      section('services')[slug.to_s]
    end

    def query_p(id)
      section('query_p')[id.to_s]
    end

    def data
      @data ||= (YAML.safe_load_file(CONFIG_PATH) || {}).freeze
    end

    def reload!
      @data = nil
      data
    end

    private

    def section(name)
      data[name] || {}
    end
  end
end
