# Create Members BOD
Member.delete_all

member = Member.new(full_name: "Dr. Wirawan Jusuf", order_no: 1)
member.job_title = "Chairman of the Board"
member.description = %q{
<p>Dr. Wirawan Jusuf is a co-founder and founding Chairman of the board of directors of Indonesia Energy Corporation Limited, and has served as the Chief Executive Officer of WJ Energy since 2014. Since 2015, Dr. Jusuf has also served as a co-founder and Commissioner of Pt. Asiabeef Biofarm Indonesia, a fully integrated and sustainable cattle business company in Indonesia. Dr. Jusuf also serves as the Director of Maderic Holding Limited, a private investment firm and our majority shareholder, which he founded in 2014. Dr. Jusuf began his professional career when he co-founded and served as the Director of Pt. Wican Indonesia Energi, an oil and gas services company, from 2012 to 2014. Dr. Jusuf earned his Master’s in Public Health at the Gajah Mada University-Jogjakarta in Central Java, Indonesia, and his medical degree at the University of Tarumanegara in Jakarta, Indonesia beforehand. We believe Dr. Jusuf is qualified to serve in his positions with our company due to his strong qualifications in business development, government relations and strategic planning.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/directors/wirawan-jusuf.jpeg").open, filename: "wirawan-jusuf.jpeg")
member.member_type = @mt1
Mobility.with_locale(:cn) {
	member.job_title = "董事会主席"
	member.description = %q{
	<p>Wirawan Jusuf 博士是印度尼西亚能源有限公司的联合创始人兼创始董事会主席，自 2014 年起担任 WJ Energy 的首席执行官。自 2015 年起，Jusuf 博士还担任印度尼西亚能源有限公司的联合创始人和创始主席。 Pt 的创始人兼专员。 Asiabeef Biofarm Indonesia 是印度尼西亚一家完全一体化、可持续发展的养牛业务公司。 Jusuf 博士还担任 Maderic Holding Limited 的董事，该公司是一家私人投资公司，也是我们的大股东，该公司于 2014 年创立。Jusuf 博士在共同创立 Pt. 并担任董事时开始了他的职业生涯。 Wican Indonesia Energi，一家石油和天然气服务公司，从 2012 年到 2014 年。Jusuf 博士在印度尼西亚中爪哇省日惹加查马达大学获得公共卫生硕士学位，并在雅加达塔鲁马内加拉大学获得医学学位。印度尼西亚提前。我们相信 Jusuf 博士有资格在我们公司担任职务，因为他在业务发展、政府关系和战略规划方面拥有丰富的资历。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Benny Dharmawan", order_no: 2)
member.job_title = "Director"
member.description = %q{
<p>Mr Dharmawan previously served as a director at PT Panasia Indo Resources Tbk, a Jakarta-listed holding company that primarily engages in yarn manufacturing, synthetic fibres and mining. Earning his Graduate Certification in Applied Finance and Investment in Kaplan, Australia and bachelor’s degree in Commerce at the Macquarie University in Australia, Mr. Dharmawan had served in several executive positions with the Macquarie Group globally from 2007 to 2015. He has experience working in Sydney, Singapore, London, and New York.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/directors/benny-dharmawan.jpeg").open, filename: "benny-dharmawan.jpeg")
member.member_type = @mt1
Mobility.with_locale(:cn) {
	member.job_title = "导演"
	member.description = %q{
	<p>Dharmawan 先生此前曾担任 PT Panasia Indo Resources Tbk 的董事，该公司是一家在雅加达上市的控股公司，主要从事纱线制造、合成纤维和采矿业。 Dharmawan 先生在澳大利亚卡普兰获得应用金融与投资研究生证书，并在澳大利亚麦格理大学获得商业学士学位，2007 年至 2015 年期间曾在麦格理集团全球范围内担任多个高管职位。他拥有在悉尼工作的经验、新加坡、伦敦和纽约。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Ahmad Fathurachman", order_no: 3)
member.job_title = "Director"
member.description = %q{
<p>Mr. Ahmad Fathurachman brings a powerful combination of technical expertise and business savvy to the oil and gas industry. With a background in electrical engineering from Universitas Jenderal Achmad Yani, he translates complex concepts into practical solutions. His experience spans SCADA and IoT implementation, fire & gas systems, and well production optimization. At Weatherford, he not only spearheaded the development of innovative tools but also secured major contracts, showcasing his understanding of market trends and customer needs.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/directors/ahmad-fathurachman.jpeg").open, filename: "ahmad-fathurachman.jpeg")
member.member_type = @mt1
Mobility.with_locale(:cn) {
	member.job_title = "导演"
	member.description = %q{
	<p>Ahmad Fathurachman 先生为石油和天然气行业带来了技术专业知识和商业头脑的强大结合。他拥有 Universitas Jenderal Achmad Yani 的电气工程背景，能够将复杂的概念转化为实际的解决方案。他的经验涵盖 SCADA 和物联网实施、火气系统以及油井生产优化。在Weatherford，他不仅领导了创新工具的开发，而且还获得了重大合同，展示了他对市场趋势和客户需求的理解。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Mirza F. Said", order_no: 4)
member.job_title = "Director"
member.description = %q{
<p>Mr. Said is a veteran and experienced executive in the oil and gas industry, whose expertise is within the energy and infrastructure sector. He earned his Master of Engineering Management from Curtin University of Technology in Perth, Australia and holds Bachelor’s degree in Engineering at the Chemical Engineering Institute Technology of Indonesia. He is a well-known figure and holds professional memberships within the Indonesian Petroleum Association (IPA) and the Society of Indonesian Petroleum Engineers (IATMI).</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/directors/mirza-f-said.jpeg").open, filename: "mirza-f-said.jpeg")
member.member_type = @mt1
Mobility.with_locale(:cn) {
	member.job_title = "导演"
	member.description = %q{
	<p>Said 先生是石油和天然气行业资深且经验丰富的高管，其专业知识涉及能源和基础设施领域。他在澳大利亚珀斯科廷科技大学获得工程管理硕士学位，并在印度尼西亚化学工程学院获得工程学士学位。他是一位知名人物，拥有印度尼西亚石油协会 (IPA) 和印度尼西亚石油工程师协会 (IATMI) 的专业会员资格。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "James J. Huang, CFA", order_no: 5)
member.job_title = "Director"
member.description = %q{
<p>Holding the Chartered Financial Analyst (CFA) designation, Mr. Huang has a strong educational and career background in finance, law and business management.</p>
<p>The co-founder of IEC maintains an attorney at Law professional license from the Brazilian Bar Association (OAB/SP).</p>
<p>He earned his bachelor’s degree in law at the Escola de Direito de São Paulo, a Brazilian private law higher education institution and Fundação Getúlio Vargas, a Brazilian higher education institution. He also participated in a Double Degree Program in Business Management Program at the Escola de Administração de Empresas de São Paulo, also in Brazil.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/directors/james-huang.jpeg").open, filename: "james-huang.jpeg")
member.member_type = @mt1
Mobility.with_locale(:cn) {
	member.job_title = "导演"
	member.description = %q{
	<p>黄先生拥有特许金融分析师（CFA）资格，在金融、法律和商业管理方面拥有深厚的教育和职业背景。</p>
	<p>IEC 的联合创始人拥有巴西律师协会 (OAB/SP) 颁发的律师专业执照。</p>
	<p>他在巴西私法高等教育机构 Escola de Direito de São Paulo 和巴西高等教育机构 Fundação Getúlio Vargas 获得了法学学士学位。他还参加了同样位于巴西圣保罗 Escola de Administração de Empresas de São Paulo 的商业管理双学位课程。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Michael L. Peterson", order_no: 6)
member.job_title = "Director"
member.description = %q{
<p>Mr. Peterson served in several executive officer positions at Pedevco Corp. (NYSE American: PED), a public company engaged primarily in the acquisition, exploration, development and production of oil and natural gas shale plays in the United States. These positions included as Chief Executive Officer, President, Chief Financial Officer and Executive Vice President.</p>
<p>Since August 2016, Mr. Peterson has served as an independent director on the board of TrxAde Group, Inc. (NASDAQ: MEDS), a web-based pharmaceutical market platform, he served in several executive positions at Aemetis, Inc. (formerly AE Biofuels Inc.), a Cupertino, California-based global advanced biofuels and renewable commodity chemicals company. These positions included as Interim President, Director and Executive Vice President. From December 2008 to July 2012, Mr. Peterson also served as Chairman and Chief Executive Officer of Nevo Energy, Inc. (formerly Solargen Energy, Inc.), a Cupertino, California-based developer of utility-scale solar farms which he helped form). From 2005 to 2006, Mr. Peterson served as a managing partner of American Institutional Partners, a venture investment fund based in Salt Lake City. From 2000 to 2004, he served as a First Vice President at Merrill Lynch, where he helped establish a new private client services division to work exclusively with high-net-worth investors. From September 1989 to January 2000, Mr. Peterson was employed by Goldman Sachs & Co. in a variety of positions and roles, including as a Vice President with the responsibility for a team of professionals that advised and managed over $7 billion in assets. Since Mr. Peterson’s retirement from Pedevco in 2018, he has served as the President of the Taipei Taiwan Mission of The Church of Jesus Christ of Latter-day Saints, in Taipei, Taiwan. Mr. Peterson received his Master degree of Business Administration at the Marriott School of Management and a Bachelor’s degree in statistics/computer science from Brigham Young University. Mr. Peterson is qualified to be a Director of our company due to his distinguished experience in managing, operating and growing both public and private companies, especially those active in the energy industry.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/directors/michael-l-peterson.jpeg").open, filename: "michael-l-peterson.jpeg")
member.member_type = @mt1
Mobility.with_locale(:cn) {
	member.job_title = "导演"
	member.description = %q{
	<p>Peterson 先生曾在 Pedevco Corp.（纽约证券交易所美国股票代码：PED）担任多个执行官职位，该公司是一家主要从事美国石油和天然气页岩油田收购、勘探、开发和生产的上市公司。这些职位包括首席执行官、总裁、首席财务官和执行副总裁。</p>
	<p>自 2016 年 8 月起，Peterson 先生担任网络医药市场平台 TrxAde Group, Inc.（纳斯达克股票代码：MEDS）董事会的独立董事，并在 Aemetis, Inc.（原 AE Biofuels Inc.）是一家总部位于加利福尼亚州库比蒂诺的全球先进生物燃料和可再生商品化学品公司。这些职位包括临时总裁、董事和执行副总裁。 2008 年 12 月至 2012 年 7 月，Peterson 先生还担任 Nevo Energy, Inc.（前身为 Solargen Energy, Inc.）的董事长兼首席执行官，该公司是一家位于加利福尼亚州库比蒂诺的公用事业规模太阳能发电厂开发商，他帮助组建了该发电厂）。 2005年至2006年，彼得森先生担任美国机构合作伙伴公司（一家位于盐湖城的风险投资基金）的执行合伙人。 2000 年至 2004 年，他担任美林证券第一副总裁，帮助建立了一个新的私人客户服务部门，专门与高净值投资者合作。从 1989 年 9 月到 2000 年 1 月，Peterson 先生受聘于高盛公司 (Goldman Sachs & Co.)，担任过多种职务，其中包括担任副总裁，负责管理专业团队，为超过 70 亿美元的资产提供建议和管理。自 2018 年从 Pedevco 退休以来，Peterson 先生一直担任台湾台北市耶稣基督后期圣徒教会台北传教会会​​长。 Peterson 先生获得了万豪管理学院的工商管理硕士学位和杨百翰大学的统计/计算机科学学士学位。彼得森先生因其在管理、运营和发展上市公司和私营公司（尤其是活跃于能源行业的公司）方面的杰出经验而有资格担任我们公司的董事。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"

member = Member.new(full_name: "Mochtar Hussein", order_no: 7)
member.job_title = "Director"
member.description = %q{
<p>Mr. Hussein has strong experience in the fields of investigative auditing, compliance as well as corporate governance. The executive, who previously served as Inspector General of The Ministry of Energy and Mineral Resources of the Republic of Indonesia in 2013-2018, and a commissioner at Jakarta-listed and state-controlled tin miner PT Timah (Persero), holds a Forensic Auditor Certification. He earned his Bachelor’s degree in Economics at the Brawijaya University in Malang, Indonesia’s East Java province.</p>
}
member.photo.attach(io: Rails.root.join("vendor/assets/images/members/directors/mochtar-hussein.jpeg").open, filename: "mochtar-hussein.jpeg")
member.member_type = @mt1
Mobility.with_locale(:cn) {
	member.job_title = "导演"
	member.description = %q{
	<p>侯赛因先生在调查审计、合规以及公司治理领域拥有丰富的经验。该高管曾于 2013 年至 2018 年担任印度尼西亚共和国能源和矿产资源部监察长，以及雅加达上市的国家控股锡矿商 PT Timah (Persero) 的专员，拥有法证审计师认证。他在印度尼西亚东爪哇省玛琅的布拉维贾亚大学获得了经济学学士学位。</p>
	}
}
member.save
puts "Create Member: #{member.full_name}"
