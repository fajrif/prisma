# Create Members Executive Team
member = Member.new(full_name: "Frank Ingriselli", order_no: 1)
member.job_title = "President"
member.description = %q{
<p>Mr. Ingriselli is a seasoned leader and entrepreneur with over 40 years of experience in the energy industry with a wide-ranging exploration and production experience in diverse geographies, business climates and political environments. From 1979 to 2001, Mr. Ingriselli worked at Texaco in diverse senior executive positions, including President of Texaco International Operations, where he directed Texaco’s global initiatives in exploration and development. While at Texaco, Mr. Ingriselli, among other activities, led Texaco’s initiatives in exploration and development in China, Russia, Australia, India, Venezuela and many other countries. From 2005 to 2018, Mr. Ingriselli was the founder, President, CEO and Chairman of PEDEVCO Corp. and Pacific Asia Petroleum, Inc., both energy companies which are or were listed on NYSE American. Mr. Ingriselli is a member of the Board of Directors of DataSight Corporation and NXT Energy Solutions Inc. (TSX:SFD; OTC QB:NSFDF) and is also on the Board of Trustees of the Eurasia Foundation, and is the founder and Chairman of Brightening Lives Foundation, Inc., a charitable public foundation. Mr. Ingriselli graduated from Boston University in 1975 with a B.S. in business administration. He also earned an M.B.A. from New York University in both finance and international finance in 1977 and a J.D. from Fordham University School of Law in 1979. Mr. Ingriselli has served as our President since 2019.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/executive_team/frank-ingriselli.jpeg").open, filename: "frank-ingriselli.jpeg")
member.member_type = @mt2
Mobility.with_locale(:cn) {
	member.job_title = "总统"
	member.description = %q{
	<p>Ingriselli 先生是一位经验丰富的领导者和企业家，在能源行业拥有 40 多年的经验，在不同的地理位置、商业环境和政治环境中拥有广泛的勘探和生产经验。从 1979 年到 2001 年，英格里塞利先生在德士古公司担任过多个高级管理职位，其中包括德士古国际运营部总裁，负责指导德士古公司在勘探和开发方面的全球计划。在德士古期间，英格里塞利先生领导了德士古在中国、俄罗斯、澳大利亚、印度、委内瑞拉和许多其他国家的勘探和开发项目。 2005年至2018年期间，Ingriselli先生担任PEDEVCO Corp.和Pacific Asia Petroleum, Inc.的创始人、总裁、首席执行官和董事长，这两家能源公司均在纽约证券交易所美国证券交易所上市。 Ingriselli 先生是 DataSight Corporation 和 NXT Energy Solutions Inc.（TSX：SFD；OTC QB：NSFDF）的董事会成员，也是 Eurasia Foundation 的董事会成员，并且是Brightening Lives Foundation, Inc. 是一家慈善公共基金会。 Ingriselli 先生 1975 年毕业于波士顿大学，获得学士学位。在工商管理方面。他还于 1977 年获得纽约大学金融和国际金融工商管理硕士学位，并于 1979 年获得福特汉姆大学法学院法学博士学位。Ingriselli 先生自 2019 年起担任我们的总裁。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Dr. Wirawan Jusuf", order_no: 2)
member.job_title = "Chairman & Chief Executive Officer"
member.description = %q{
<p>Dr. Jusuf is a co-founder and founding Chairman of the board of directors of Indonesia Energy Corporation Limited and has been leading our Company since 2014. Dr. Jusuf also serves as the Director of Maderic Holding Limited, a private investment firm and our majority shareholder. Dr. Jusuf earned his Masters in Public Health at the Gajah Mada University-Jogjakarta in Central Java, Indonesia, and his medical degree at the University of Tarumanegara in Jakarta, Indonesia. Dr. Jusuf has strong qualifications in business development, government relations and strategic planning.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/executive_team/wirawan-jusuf.jpeg").open, filename: "wirawan-jusuf.jpeg")
member.member_type = @mt2
Mobility.with_locale(:cn) {
	member.job_title = "董事长兼首席执行官"
	member.description = %q{
	<p>Jusuf 博士是 Indonesia Energy Corporation Limited 的联合创始人兼创始董事会主席，自 2014 年以来一直领导我们公司。Jusuf 博士还担任 Maderic Holding Limited（一家私人投资公司，也是我们的多数股权）的董事。股东。 Jusuf 博士在印度尼西亚中爪哇省日惹加查马达大学获得公共卫生硕士学位，并在印度尼西亚雅加达塔鲁马内加拉大学获得医学学位。 Jusuf 博士在业务发展、政府关系和战略规划方面拥有丰富的资历。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Dr. Chiahsin (Charlie) Wu", order_no: 3)
member.job_title = "Chief Technology Officer"
member.description = %q{
<p>Dr. Wu has served as our Chief Technology Officer since 2018. Dr. Wu is a highly qualified and recognized oil and gas industry veteran with over 40 years of experience. In his successful career, Dr. Wu worked in a variety of roles internationally with ARCO (Atlantic Richfield Company, now recognized as BP Plc), holding the positions of Geological Specialist, New Venture Geologist and Exploration Coordinator for ARCO in Indonesia. During his time in ARCO, Dr. Wu earned ARCO’s “Exploration Excellence Award” on the Vice-President Level for providing training to worldwide staff in geohistory and basin modelling with subsequent exploration successes while he was in Plano, Texas. Dr. Wu completed his Postgraduate Diploma in Business Administration at DeMontfort University in 2000 and earned his Ph.D. in Geosciences in 1991 at the University of Texas. He also completed his Masters of Science in Geology at the University of Toledo in 1979. Prior to his graduate studies, Dr. Wu earned his Bachelors of Science degree in Geology at National Taiwan University in 1975. Dr. Wu has also served as Adjunct Professor at the University of Texas at Dallas and University of Indonesia where he has taught 8 regular and industrial courses. Dr. Wu has been responsible for building and leading the upstream exploration and production teams for 3 independent oil and gas companies in Indonesia over the last 15 years, having operated 7 different oil blocks in the country. His outstanding achievements ensure he is highly qualified to implement our Company’s growth strategy plan.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/executive_team/charlie.jpeg").open, filename: "charlie.jpeg")
member.member_type = @mt2
Mobility.with_locale(:cn) {
	member.job_title = "首席技术官"
	member.description = %q{
	<p>吴博士自 2018 年起担任我们的首席技术官。吴博士是一位高素质、公认的石油和天然气行业资深人士，拥有 40 多年的经验。在其成功的职业生涯中，吴博士曾在 ARCO（Atlantic Richfield Company，现更名为 BP Plc）担任过多个国际职务，曾担任 ARCO 在印度尼西亚的地质专家、新风险地质学家和勘探协调员等职务。在 ARCO 任职期间，吴博士在德克萨斯州普莱诺期间为全球员工提供了地质历史和盆地建模方面的培训，并取得了随后的勘探成功，因此荣获 ARCO 副总裁级“勘探卓越奖”。吴博士于2000年在德蒙福特大学完成了工商管理研究生文凭，并于2007年获得了博士学位。 1991 年在德克萨斯大学获得地球科学博士学位。他还于 1979 年在托莱多大学完成了地质学理学硕士学位。在研究生学习之前，吴博士于 1975 年在国立台湾大学获得了地质学理学学士学位。吴博士还担任兼职教授他曾在德克萨斯大学达拉斯分校和印度尼西亚大学教授 8 门常规课程和工业课程。吴博士在过去15年里负责组建和领导印度尼西亚3家独立石油天然气公司的上游勘探和生产团队，在该国运营了7个不同的石油区块。他的杰出成就确保他完全有能力实施我们公司的增长战略计划。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Gregory Overholtzer", order_no: 4)
member.job_title = "Chief Financial Officer"
member.description = %q{
<p>Mr. Overholtzer is an experienced Chief Financial Officer with a strong background in publicly traded corporations in the oil and gas industry. He has served as the CFO of PEDEVCO Corp, a Houston-headquartered oil and gas company that is listed in the NYSE America. The executive, who earned his MBA and Bachelor of Arts degrees from the University of California, Berkeley in the United States.He also has a long list of senior positions – as the CFO, Corporate Controller and Senior Director – in a number of companies engaged in various sectors, including energy-related, high-tech and bio-tech industries. He has served as our CFO since 2019.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/executive_team/gregory-overholtzer.jpeg").open, filename: "gregory-overholtzer.jpeg")
member.member_type = @mt2
Mobility.with_locale(:cn) {
	member.job_title = "首席财务官"
	member.description = %q{
	<p>Overholtzer 先生是一位经验丰富的首席财务官，在石油和天然气行业的上市公司拥有丰富的背景。他曾担任 PEDEVCO Corp 的首席财务官，该公司是一家总部位于休斯敦的石油和天然气公司，在美国纽约证券交易所上市。这位高管获得了美国加州大学伯克利分校的工商管理硕士学位和文学学士学位。他还在多家公司担任过一长串高级职位，包括首席财务官、公司财务总监和高级总监。各个领域，包括能源相关、高科技和生物技术行业。他自 2019 年起担任我们的首席财务官。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Mirza F. Said", order_no: 5)
member.job_title = "Chief Operating Officer"
member.description = %q{
<p>Mirza F. Said has served as Chief Operating Officer and Director of our Company since 2018 and has served as Chief Executive Officer of our subsidiary PT. Green World Nusantara since 2014. Prior to joining our Company, Mr. Said was the President Director of Pt. Humpuss Patragas, a subsidiary of an Indonesia integrated energy business that had operations in the upstream, transportation and refining industry. Mr. Said has built his professional career in a diverse range of roles pertaining to drilling and operations since 1991. He has held several senior positions in several companies, including BP Indonesia, from 2001 to 2004, during which time, as a result of his achievements, he was awarded the “Spot Recognition Award of Significant Contribution in Managing & Placing”. Mr. Said earned his Master of Engineering Management at the Curtin University of Technology in Perth, Australia, and had completed his Bachelor’s degree in Engineering at the Chemical Engineering Institute Technology of Indonesia. Mr. Said holds professional memberships with the Indonesian Petroleum Association (IPA) and Society of Indonesian Petroleum Engineers (IATMI). Mr. Said is qualified to serve in his positions with our Company as a result of his professional experience in drilling, operations and business development.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/executive_team/mirza-f-said.jpeg").open, filename: "mirza-f-said.jpeg")
member.member_type = @mt2
Mobility.with_locale(:cn) {
	member.job_title = "首席运营官"
	member.description = %q{
	<p>Mirza F. Said 自 2018 年起担任本公司首席运营官兼董事，并担任我们子公司 PT. 的首席执行官。自 2014 年起加入绿世界 Nusantara。在加入我们公司之前，Said 先生曾担任 Pt. Nusantara 的总裁董事。 Humpuss Patragas 是一家印度尼西亚综合能源公司的子公司，该公司在上游、运输和炼油行业开展业务。自 1991 年以来，Said 先生在与钻井和作业相关的各种职位上建立了自己的职业生涯。2001 年至 2004 年，他在多家公司担任过多个高级职位，其中包括 BP Indonesia。凭借其卓越的成就，他被授予“管理和安置方面的重大贡献表彰奖”。 Said 先生在澳大利亚珀斯科廷科技大学获得工程管理硕士学位，并在印度尼西亚化学工程学院获得工程学士学位。 Said 先生是印度尼西亚石油协会 (IPA) 和印度尼西亚石油工程师协会 (IATMI) 的专业会员。 Said 先生因其在钻井、运营和业务开发方面的专业经验而有资格在本公司任职。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "James J. Huang, CFA", order_no: 6)
member.job_title = "Chief Investment Officer"
member.description = %q{
<p>James J. Huang is a co-founder, Chief Investment Officer and Director of our Company since inception. Mr. Huang holds the Chartered Financial Analyst® (CFA) designation and maintains an Attorney at Law professional license from the Brazilian Bar Association (OAB/SP). Mr. Huang earned his Bachelor’s degree in law at the Escola de Direito de São Paulo in Brazil at Fundação Getúlio Vargas and previously participated at a Double Degree Business Management Program at the Escola de Administração de Empresas de São Paulo also at Fundação Getúlio Vargas. Mr. Huang is qualified to serve in his positions due to his expertise in finance, law and business management.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/executive_team/james-huang.jpeg").open, filename: "james-huang.jpeg")
member.member_type = @mt2
Mobility.with_locale(:cn) {
	member.job_title = "首席投资官"
	member.description = %q{
	<p>James J. Huang 自公司成立以来一直担任公司联合创始人、首席投资官兼董事。黄先生拥有特许金融分析师® (CFA) 资格，并拥有巴西律师协会 (OAB/SP) 颁发的律师专业执照。黄先生在巴西 Escola de Direito de São Paulo 的 Fundação Getúlio Vargas 获得了法学学士学位，此前还参加了 Escola de Administração de Empresas de São Paulo 的 Fundação Getúlio Vargas 的双学位商业管理课程。黄先生具有财务、法律和企业管理方面的专业知识，符合担任其职务的资格。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"
