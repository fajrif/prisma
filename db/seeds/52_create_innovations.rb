# CREATE Innovations
Innovation.delete_all

# Get titles and descriptions from locale files
titles_en = I18n.t('dooh_innovations.title', locale: :en)
descriptions_en = I18n.t('dooh_innovations.list', locale: :en)
titles_id = I18n.t('dooh_innovations.title', locale: :id)
descriptions_id = I18n.t('dooh_innovations.list', locale: :id)

# Create 12 innovations
12.times do |index|
  innovation = Innovation.new

  # Set icon filename
  innovation.icon = "icon-#{index + 1}.png"

  # Set English translations
  I18n.locale = :en
  innovation.title = titles_en[index]
  innovation.description = descriptions_en[index]

  # Set Indonesian translations
  I18n.locale = :id
  innovation.title = titles_id[index]
  innovation.description = descriptions_id[index]

  innovation.save!

  # Reset to default locale
  I18n.locale = :en
  puts "Created Innovation: #{innovation.title}"
end

# Reset locale
I18n.locale = I18n.default_locale
