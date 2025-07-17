# Create Default Administrator
#
Role.delete_all
puts "create roles"
adm1 = Role.create(:name => "admin", :description => "System Administrator granted access to all resources")
adm2 = Role.create(:name => "developer", :description => "Web Developer able to access to content resources")
adm3 = Role.create(:name => "investor", :description => "Admin to manage investor contacts")

Admin.delete_all
puts "create administrator"
Admin.create(:full_name => "Administrator", :email => "admin@indo-energy.com", :password => "secret1234!", :password_confirmation => "secret1234!", role: adm1)
Admin.create(:full_name => "Admin Website", :email => "developer@indo-energy.com", :password => "secret1234!", :password_confirmation => "secret1234!", role: adm2)
Admin.create(:full_name => "Admin Investor", :email => "investor@indo-energy.com", :password => "secret1234!", :password_confirmation => "secret1234!", role: adm3)

Setting.delete_all
puts "create setting"
Setting.create(admin_investor: "investor.relations@prisma-ads.com")
