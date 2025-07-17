# Create Default Banner Section
BannerSection.delete_all
puts "create all banner sections"
@bs1 = BannerSection.create(name: "Home")

@bs2 = BannerSection.create(name: "About Us")
@bs3 = BannerSection.create(name: "Portfolio")
@bs4 = BannerSection.create(name: "Sustainability")
@bs5 = BannerSection.create(name: "Investor Relations")
@bs6 = BannerSection.create(name: "Research Reports")
@bs7 = BannerSection.create(name: "Corporate Governance")

@bs8 = BannerSection.create(name: "Sumatra Kruh Block")
@bs9 = BannerSection.create(name: "Java Citarum Block")

@bs10 = BannerSection.create(name: "Press-Release")
@bs11 = BannerSection.create(name: "Media")
@bs12 = BannerSection.create(name: "Contact")
