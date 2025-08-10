# Create Default Banner Section
BannerSection.delete_all
puts "create all banner sections"
@bs1 = BannerSection.create(name: "Home")

@bs2 = BannerSection.create(name: "About Us")
@bs3 = BannerSection.create(name: "Portfolio") # index
@bs4 = BannerSection.create(name: "Services") # index
@bs5 = BannerSection.create(name: "Industries") # index
@bs6 = BannerSection.create(name: "Career") # index
@bs7 = BannerSection.create(name: "Blog") # index
@bs8 = BannerSection.create(name: "Contact Us") # index


# Services
# Static Billboard Advertising
# Digital Billboard Advertising
# Creative OOH Branding
# Transit Advertising
# OOH Media Dashboard Access
# PiX Creative Mindworks

@bs10 = BannerSection.create(name: "Static Billboard Advertising")
@bs11 = BannerSection.create(name: "Digital Billboard Advertising")
@bs12 = BannerSection.create(name: "Creative OOH Branding")
@bs13 = BannerSection.create(name: "Transit Advertising")
@bs14 = BannerSection.create(name: "OOH Media Dashboard Access")
@bs15 = BannerSection.create(name: "PiX Creative Mindworks")

# Industries
# FMCG
# E-Commerce
# Telecommunications
# Automotive
# Technology & Electronics
# Entertainment & Streaming
# Transportation & Superapp
# Financial Services & Fintech

@bs20 = BannerSection.create(name: "FMCG")
@bs21 = BannerSection.create(name: "E-Commerce")
@bs22 = BannerSection.create(name: "Telecommunications")
@bs23 = BannerSection.create(name: "Automotive")
@bs24 = BannerSection.create(name: "Technology & Electronics")
@bs25 = BannerSection.create(name: "Entertainment & Streaming")
@bs26 = BannerSection.create(name: "Transportation & Superapp")
@bs27 = BannerSection.create(name: "Financial Services & Fintech")
