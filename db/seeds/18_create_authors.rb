# create default authors

@author1 = Author.new(:name => "Michael Heim")
@author1.title = "Senior Research Analyst<br/>Natural Resources"
@author1.company_name = "Noble Capital Markets Inc."
@author1.email = "mheim@noblecapitalmarkets.com"
@author1.phone = "(314) 308-9711"
@author1.save

@author2 = Author.new(:name => "Marco Rodriguez")
@author2.title = "Research Analyst<br/>Natural Resources"
@author2.company_name = "Stonegate Capital Partners"
@author2.email = "marco@stonegateinc.com"
@author2.phone = "214-987-4121"
@author2.save
