# Create Article - Press Release Category
Article.delete_all

press_release = Article.new(name: "IMPORTANT DEADLINE REMINDER: The Schall Law Firm Encourages Investors in Innodata Inc. with Losses of $100,000 to Contact the Firm", category: @cat1)
press_release.title = "IMPORTANT DEADLINE REMINDER: The Schall Law Firm Encourages Investors in Innodata Inc. with Losses of $100,000 to Contact the Firm"
press_release.content = %q{
		<p>The Schall Law Firm, a national shareholder rights litigation firm, reminds investors of a class action lawsuit against Innodata Inc. ("Innodata" or "the Company") (NASDAQ:INOD) for violations of 10(b) and 20(a) of the Securities Exchange Act of 1934 and Rule 10b-5 promulgated thereunder by the U.S. Securities and Exchange Commission.</p>
		<p>Investors who purchased the Company's securities between May 9, 2019 and February 14, 2024, inclusive (the "Class Period"), are encouraged to contact the firm before April 22, 2024.</p>
		<p>If you are a shareholder who suffered a loss, click here to participate.</p>
		<p>We also encourage you to contact Brian Schall of the Schall Law Firm, 2049 Century Park East, Suite 2460, Los Angeles, CA 90067, at 310-301-3335, to discuss your rights free of charge. You can also reach us through the firm's website at www.schallfirm.com, or by email at bschall@schallfirm.com.</p>
		<p>The class, in this case, has not yet been certified, and until certification occurs, you are not represented by an attorney. If you choose to take no action, you can remain an absent class member. According to the Complaint, the Company made false and misleading statements to the market. Innodata failed to develop viable AI technology. Contrary to the Company's claims, its GoldenGate AI platform was basic software created by a small group of employees. The Company would not utilize AI in its new Silicon Valley contracts to any real degree. The Company failed to invest in AI research & development. Based on these facts, the Company's public statements were false and materially misleading throughout the class period. When the market learned the truth about Innodata, investors suffered damages.</p>
		<p>The Schall Law Firm represents investors around the world and specializes in securities class action lawsuits and shareholder rights litigation. This press release may be considered Attorney Advertising in some jurisdictions under the applicable law and rules of ethics.</p>
	}
Mobility.with_locale(:cn) {
press_release.title = "重要截止日期提醒：Schall 律师事务所鼓励损失 100,000 美元的 Innodata Inc. 投资者联系该公司"
press_release.content = %q{
		<p>全国股东权利诉讼公司 Schall 律师事务所提醒投资者注意针对 Innodata Inc.（“Innodata”或“公司”）（纳斯达克股票代码：INOD）违反 10(b) 和 20(a) 的集体诉讼1934 年《证券交易法》以及美国证券交易委员会据此颁布的第 10b-5 条规则。</p>
		<p>我们鼓励在2019年5月9日至2024年2月14日（含）（“集体诉讼期”）期间购买该公司证券的投资者在2024年4月22日之前联系该公司。</p>
		<p>如果您是遭受损失的股东，请点击此处参与。</p>
		<p>我们还鼓励您联系 Schall 律师事务所（地址：2049 Century Park East, Suite 2460, Los Angeles, CA 90067）的 Brian Schall，电话：310-301-3335，免费讨论您的权利。您还可以通过公司网站 www.schallfirm.com 或发送电子邮件至 bschall@schallfirm.com 与我们联系。</p>
		<p>在这种情况下，该班级尚未获得认证，并且在获得认证之前，您没有律师代表。如果您选择不采取任何行动，您可以继续缺席集体成员身份。根据投诉，该公司向市场做出了虚假和误导性陈述。 Innodata未能开发出可行的人工智能技术。与该公司的说法相反，其 GoldenGate AI 平台是由一小群员工创建的基础软件。该公司不会在其新的硅谷合同中真正程度地利用人工智能。公司未能投资人工智能研发。基于这些事实，公司的公开声明在整个集体诉讼期间都是虚假的且具有重大误导性。当市场了解Innodata的真相时，投资者遭受了损失。</p>
		<p>Schall 律师事务所代表世界各地的投资者，专门从事证券集体诉讼和股东权利诉讼。根据适用的法律和道德规则，本新闻稿在某些司法管辖区可能被视为律师广告。</p>
	}
}
press_release.published_date = DateTime.strptime('09/26/2023 1:46 AM', '%m/%d/%Y %I:%M %p')
press_release.save
puts "Create Press Release: #{press_release.title}"

press_release = Article.new(name: "The Schall Law Firm Encourages Investors in Innodata Inc. with Losses of $50,000 to Contact the Firm", category: @cat1)
press_release.title = "The Schall Law Firm Encourages Investors in Innodata Inc. with Losses of $50,000 to Contact the Firm"
press_release.content = %q{
		<p>The Schall Law Firm, a national shareholder rights litigation firm, reminds investors of a class action lawsuit against Innodata Inc. ("Innodata" or "the Company") (NASDAQ:INOD) for violations of 10(b) and 20(a) of the Securities Exchange Act of 1934 and Rule 10b-5 promulgated thereunder by the U.S. Securities and Exchange Commission.</p>
		<p>Investors who purchased the Company's securities between May 9, 2019 and February 14, 2024, inclusive (the "Class Period"), are encouraged to contact the firm before April 22, 2024.</p>
		<p>If you are a shareholder who suffered a loss, click here to participate.</p>
		<p>We also encourage you to contact Brian Schall of the Schall Law Firm, 2049 Century Park East, Suite 2460, Los Angeles, CA 90067, at 310-301-3335, to discuss your rights free of charge. You can also reach us through the firm's website at www.schallfirm.com, or by email at bschall@schallfirm.com.</p>
		<p>The class, in this case, has not yet been certified, and until certification occurs, you are not represented by an attorney. If you choose to take no action, you can remain an absent class member. According to the Complaint, the Company made false and misleading statements to the market. Innodata failed to develop viable AI technology. Contrary to the Company's claims, its GoldenGate AI platform was basic software created by a small group of employees. The Company would not utilize AI in its new Silicon Valley contracts to any real degree. The Company failed to invest in AI research & development. Based on these facts, the Company's public statements were false and materially misleading throughout the class period. When the market learned the truth about Innodata, investors suffered damages.</p>
		<p>The Schall Law Firm represents investors around the world and specializes in securities class action lawsuits and shareholder rights litigation. This press release may be considered Attorney Advertising in some jurisdictions under the applicable law and rules of ethics.</p>
	}
Mobility.with_locale(:cn) {
press_release.title = "Schall 律师事务所鼓励 Innodata Inc. 损失 50,000 美元的投资者联系该公司"
press_release.content = %q{
		<p>全国股东权利诉讼公司 Schall 律师事务所提醒投资者注意针对 Innodata Inc.（“Innodata”或“公司”）（纳斯达克股票代码：INOD）违反 10(b) 和 20(a) 的集体诉讼1934 年《证券交易法》以及美国证券交易委员会据此颁布的第 10b-5 条规则。</p>
		<p>我们鼓励在2019年5月9日至2024年2月14日（含）（“集体诉讼期”）期间购买该公司证券的投资者在2024年4月22日之前联系该公司。</p>
		<p>如果您是遭受损失的股东，请点击此处参与。</p>
		<p>我们还鼓励您联系 Schall 律师事务所（地址：2049 Century Park East, Suite 2460, Los Angeles, CA 90067）的 Brian Schall，电话：310-301-3335，免费讨论您的权利。您还可以通过公司网站 www.schallfirm.com 或发送电子邮件至 bschall@schallfirm.com 与我们联系。</p>
		<p>在这种情况下，该班级尚未获得认证，并且在获得认证之前，您没有律师代表。如果您选择不采取任何行动，您可以继续缺席集体成员身份。根据投诉，该公司向市场做出了虚假和误导性陈述。 Innodata未能开发出可行的人工智能技术。与该公司的说法相反，其 GoldenGate AI 平台是由一小群员工创建的基础软件。该公司不会在其新的硅谷合同中真正程度地利用人工智能。公司未能投资人工智能研发。基于这些事实，公司的公开声明在整个集体诉讼期间都是虚假的且具有重大误导性。当市场了解Innodata的真相时，投资者遭受了损失。</p>
		<p>Schall 律师事务所代表世界各地的投资者，专门从事证券集体诉讼和股东权利诉讼。根据适用的法律和道德规则，本新闻稿在某些司法管辖区可能被视为律师广告。</p>
	}
}
press_release.published_date = DateTime.strptime('09/26/2023 1:36 AM', '%m/%d/%Y %I:%M %p')
press_release.save
puts "Create Press Release: #{press_release.title}"

press_release = Article.new(name: "The Schall Law Firm Encourages Investors in Innodata Inc. with Losses of $40,000 to Contact the Firm", category: @cat1)
press_release.title = "The Schall Law Firm Encourages Investors in Innodata Inc. with Losses of $40,000 to Contact the Firm"
press_release.content = %q{
		<p>The Schall Law Firm, a national shareholder rights litigation firm, reminds investors of a class action lawsuit against Innodata Inc. ("Innodata" or "the Company") (NASDAQ:INOD) for violations of 10(b) and 20(a) of the Securities Exchange Act of 1934 and Rule 10b-5 promulgated thereunder by the U.S. Securities and Exchange Commission.</p>
		<p>Investors who purchased the Company's securities between May 9, 2019 and February 14, 2024, inclusive (the "Class Period"), are encouraged to contact the firm before April 22, 2024.</p>
		<p>If you are a shareholder who suffered a loss, click here to participate.</p>
		<p>We also encourage you to contact Brian Schall of the Schall Law Firm, 2049 Century Park East, Suite 2460, Los Angeles, CA 90067, at 310-301-3335, to discuss your rights free of charge. You can also reach us through the firm's website at www.schallfirm.com, or by email at bschall@schallfirm.com.</p>
		<p>The class, in this case, has not yet been certified, and until certification occurs, you are not represented by an attorney. If you choose to take no action, you can remain an absent class member. According to the Complaint, the Company made false and misleading statements to the market. Innodata failed to develop viable AI technology. Contrary to the Company's claims, its GoldenGate AI platform was basic software created by a small group of employees. The Company would not utilize AI in its new Silicon Valley contracts to any real degree. The Company failed to invest in AI research & development. Based on these facts, the Company's public statements were false and materially misleading throughout the class period. When the market learned the truth about Innodata, investors suffered damages.</p>
		<p>The Schall Law Firm represents investors around the world and specializes in securities class action lawsuits and shareholder rights litigation. This press release may be considered Attorney Advertising in some jurisdictions under the applicable law and rules of ethics.</p>
	}
Mobility.with_locale(:cn) {
press_release.title = "Schall 律师事务所鼓励 Innodata Inc. 损失 40,000 美元的投资者联系该公司"
press_release.content = %q{
		<p>全国股东权利诉讼公司 Schall 律师事务所提醒投资者注意针对 Innodata Inc.（“Innodata”或“公司”）（纳斯达克股票代码：INOD）违反 10(b) 和 20(a) 的集体诉讼1934 年《证券交易法》以及美国证券交易委员会据此颁布的第 10b-5 条规则。</p>
		<p>我们鼓励在2019年5月9日至2024年2月14日（含）（“集体诉讼期”）期间购买该公司证券的投资者在2024年4月22日之前联系该公司。</p>
		<p>如果您是遭受损失的股东，请点击此处参与。</p>
		<p>我们还鼓励您联系 Schall 律师事务所（地址：2049 Century Park East, Suite 2460, Los Angeles, CA 90067）的 Brian Schall，电话：310-301-3335，免费讨论您的权利。您还可以通过公司网站 www.schallfirm.com 或发送电子邮件至 bschall@schallfirm.com 与我们联系。</p>
		<p>在这种情况下，该班级尚未获得认证，并且在获得认证之前，您没有律师代表。如果您选择不采取任何行动，您可以继续缺席集体成员身份。根据投诉，该公司向市场做出了虚假和误导性陈述。 Innodata未能开发出可行的人工智能技术。与该公司的说法相反，其 GoldenGate AI 平台是由一小群员工创建的基础软件。该公司不会在其新的硅谷合同中真正程度地利用人工智能。公司未能投资人工智能研发。基于这些事实，公司的公开声明在整个集体诉讼期间都是虚假的且具有重大误导性。当市场了解Innodata的真相时，投资者遭受了损失。</p>
		<p>Schall 律师事务所代表世界各地的投资者，专门从事证券集体诉讼和股东权利诉讼。根据适用的法律和道德规则，本新闻稿在某些司法管辖区可能被视为律师广告。</p>
	}
}
press_release.published_date = DateTime.strptime('09/26/2023 1:26 AM', '%m/%d/%Y %I:%M %p')
press_release.save
puts "Create Press Release: #{press_release.title}"

press_release = Article.new(name: "The Schall Law Firm Encourages Investors in Data Inc. with Losses of $30,000 to Contact the Firm", category: @cat1)
press_release.title = "The Schall Law Firm Encourages Investors in Data Inc. with Losses of $30,000 to Contact the Firm"
press_release.content = %q{
		<p>The Schall Law Firm, a national shareholder rights litigation firm, reminds investors of a class action lawsuit against Innodata Inc. ("Innodata" or "the Company") (NASDAQ:INOD) for violations of 10(b) and 20(a) of the Securities Exchange Act of 1934 and Rule 10b-5 promulgated thereunder by the U.S. Securities and Exchange Commission.</p>
		<p>Investors who purchased the Company's securities between May 9, 2019 and February 14, 2024, inclusive (the "Class Period"), are encouraged to contact the firm before April 22, 2024.</p>
		<p>If you are a shareholder who suffered a loss, click here to participate.</p>
		<p>We also encourage you to contact Brian Schall of the Schall Law Firm, 2049 Century Park East, Suite 2460, Los Angeles, CA 90067, at 310-301-3335, to discuss your rights free of charge. You can also reach us through the firm's website at www.schallfirm.com, or by email at bschall@schallfirm.com.</p>
		<p>The class, in this case, has not yet been certified, and until certification occurs, you are not represented by an attorney. If you choose to take no action, you can remain an absent class member. According to the Complaint, the Company made false and misleading statements to the market. Innodata failed to develop viable AI technology. Contrary to the Company's claims, its GoldenGate AI platform was basic software created by a small group of employees. The Company would not utilize AI in its new Silicon Valley contracts to any real degree. The Company failed to invest in AI research & development. Based on these facts, the Company's public statements were false and materially misleading throughout the class period. When the market learned the truth about Innodata, investors suffered damages.</p>
		<p>The Schall Law Firm represents investors around the world and specializes in securities class action lawsuits and shareholder rights litigation. This press release may be considered Attorney Advertising in some jurisdictions under the applicable law and rules of ethics.</p>
	}
Mobility.with_locale(:cn) {
press_release.title = "Schall 律师事务所鼓励损失 30,000 美元的 Data Inc. 投资者联系该公司"
press_release.content = %q{
		<p>全国股东权利诉讼公司 Schall 律师事务所提醒投资者注意针对 Innodata Inc.（“Innodata”或“公司”）（纳斯达克股票代码：INOD）违反 10(b) 和 20(a) 的集体诉讼1934 年《证券交易法》以及美国证券交易委员会据此颁布的第 10b-5 条规则。</p>
		<p>我们鼓励在2019年5月9日至2024年2月14日（含）（“集体诉讼期”）期间购买该公司证券的投资者在2024年4月22日之前联系该公司。</p>
		<p>如果您是遭受损失的股东，请点击此处参与。</p>
		<p>我们还鼓励您联系 Schall 律师事务所（地址：2049 Century Park East, Suite 2460, Los Angeles, CA 90067）的 Brian Schall，电话：310-301-3335，免费讨论您的权利。您还可以通过公司网站 www.schallfirm.com 或发送电子邮件至 bschall@schallfirm.com 与我们联系。</p>
		<p>在这种情况下，该班级尚未获得认证，并且在获得认证之前，您没有律师代表。如果您选择不采取任何行动，您可以继续缺席集体成员身份。根据投诉，该公司向市场做出了虚假和误导性陈述。 Innodata未能开发出可行的人工智能技术。与该公司的说法相反，其 GoldenGate AI 平台是由一小群员工创建的基础软件。该公司不会在其新的硅谷合同中真正程度地利用人工智能。公司未能投资人工智能研发。基于这些事实，公司的公开声明在整个集体诉讼期间都是虚假的且具有重大误导性。当市场了解Innodata的真相时，投资者遭受了损失。</p>
		<p>Schall 律师事务所代表世界各地的投资者，专门从事证券集体诉讼和股东权利诉讼。根据适用的法律和道德规则，本新闻稿在某些司法管辖区可能被视为律师广告。</p>
	}
}
press_release.published_date = DateTime.strptime('09/26/2023 1:16 AM', '%m/%d/%Y %I:%M %p')
press_release.save
puts "Create Press Release: #{press_release.title}"
