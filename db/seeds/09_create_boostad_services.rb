# CREATE Boostad Services
BoostadService.delete_all

# Get titles and descriptions from locale files
titles_en = I18n.t('boostad_services.title', locale: :en)
descriptions_en = I18n.t('boostad_services.list', locale: :en)
titles_id = I18n.t('boostad_services.title', locale: :id)
descriptions_id = I18n.t('boostad_services.list', locale: :id)

# Create 4 boostad services
4.times do |index|
  bs = BoostadService.new

  # Set English translations
  I18n.locale = :en
  bs.title = titles_en[index]
  bs.description = descriptions_en[index]

  # Set Indonesian translations
  I18n.locale = :id
  bs.title = titles_id[index]
  bs.description = descriptions_id[index]

  # Attach image
  image_path = Rails.root.join("vendor/assets/images/boostad/boostad-#{index + 1}.png")
  if File.exist?(image_path)
    bs.image.attach(io: image_path.open, filename: "boostad-#{index + 1}.png")
  end

  bs.save

  # Reset to default locale
  I18n.locale = :en
  puts "Created Boostad Service: #{bs.title}"
end

# Reset locale
I18n.locale = I18n.default_locale
