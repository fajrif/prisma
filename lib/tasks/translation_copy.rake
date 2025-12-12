namespace :translations do
  desc "Copy all EN translations into ID for Article"
  task copy_en_to_id: :environment do
    puts "Copying translations for Articles…"

    Article.find_each do |article|
      en_title             = nil
      en_short_description = nil
      en_meta_title        = nil
      en_meta_description  = nil
      en_content           = nil

      Mobility.with_locale(:en) do
        en_title             = article.title
        en_short_description = article.short_description
        en_meta_title        = article.meta_title
        en_meta_description  = article.meta_description
        en_content           = article.content
      end

      Mobility.with_locale(:id) do
        article.title             = en_title
        article.short_description = en_short_description
        article.meta_title        = en_meta_title
        article.meta_description  = en_meta_description
        article.content           = en_content
        article.save!
      end

      puts "✓ Copied: #{article.id}"
    end

    puts "Done!"
  end
end
