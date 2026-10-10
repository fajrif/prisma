namespace :translations do
  # USANG: tugas sekali jalan lama. Meta title/description kini di seo_settings, bukan kolom
  # artikel, jadi bagian meta di bawah dilewati (hanya judul, ringkasan, dan isi yang disalin).
  # Jangan dijalankan di production tanpa memeriksa: ia menimpa kolom ID dengan teks EN.
  desc "Copy all EN translations into ID for Article (usang)"
  task copy_en_to_id: :environment do
    puts "Copying translations for Articles…"

    Article.find_each do |article|
      en_title             = nil
      en_short_description = nil
      en_content           = nil

      Mobility.with_locale(:en) do
        en_title             = article.title
        en_short_description = article.short_description
        en_content           = article.content
      end

      Mobility.with_locale(:id) do
        article.title             = en_title
        article.short_description = en_short_description
        article.content           = en_content
        article.save!
      end

      puts "✓ Copied: #{article.id}"
    end

    puts "Done!"
  end
end
