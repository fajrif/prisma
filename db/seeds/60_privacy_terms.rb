# Privacy Policy & Terms and Conditions (EN / ID / CN) — draf standar siap tayang.
#
# JALANKAN HANYA FILE INI, JANGAN `bin/rails db:seed`:
#   cd /home/deployer/prisma
#   RAILS_ENV=production bin/rails runner db/seeds/60_privacy_terms.rb
#
# `db:seed` memuat SEMUA file di db/seeds/ berurutan, termasuk 30_create_pages.rb yang menjalankan
# `Page.delete_all` (dan seed lain yang mengosongkan tabelnya) — itu akan menghapus seluruh halaman situs.
#
# Perilaku (aman dijalankan berulang):
# - Halaman dicari per slug (`privacy-policy`, `terms`), lalu per judul. Belum ada -> dibuat.
# - Konten tiap bahasa hanya ditulis bila masih kosong atau masih placeholder "[Isi oleh tim ...]" dari
#   `rake seo:legal_pages`. Teks yang sudah diedit tim Prisma di admin TIDAK ditimpa.
# - Meta title/description (di seo_settings) hanya diisi bila masih kosong.
# - Halaman diterbitkan (status Published) bila ada konten yang ditulis pada run ini.
#
# Opsi (ENV):
#   PUBLISH=0  tulis konten tetapi biarkan/ubah ke Draft (tidak tampil di situs & footer)
#   FORCE=1    timpa konten & meta SEMUA bahasa, termasuk yang sudah diedit
#   ONLY=slug[,slug]    batasi ke halaman tertentu (privacy-policy, terms); halaman lain tidak disentuh
#   LOCALES=en,id       batasi ke bahasa tertentu (konten & meta); bahasa lain tidak disentuh
#
# Memulihkan halaman yang strukturnya rusak (mis. <h2> menjadi <div> setelah disimpan dari editor admin)
# tanpa menyentuh halaman/bahasa lain:
#   RAILS_ENV=production FORCE=1 ONLY=privacy-policy LOCALES=en,id bin/rails runner db/seeds/60_privacy_terms.rb
#
# CATATAN ISI: ini template standar, bukan nasihat hukum. Wajib ditinjau legal Prisma. Terjemahan Mandarin
# (Sederhana) perlu dicek penutur asli. Poin yang perlu dikonfirmasi Prisma ada di ROADMAP_PLAN.md (T3).
# Sengaja TIDAK memuat angka masa simpan data atau klaim sertifikasi keamanan karena belum diputuskan Prisma.

publish = ENV['PUBLISH'] != '0'
force   = ENV['FORCE'] == '1'
only    = ENV['ONLY'].to_s.split(',').map(&:strip).reject(&:empty?)
locales = ENV['LOCALES'].to_s.split(',').map { |l| l.strip.downcase.to_sym }.reject { |l| l == :'' }
locales = %i[en id cn] if locales.empty?
unknown = locales - %i[en id cn]
abort "LOCALES tidak dikenal: #{unknown.join(', ')} (pilihan: en, id, cn)" if unknown.any?

placeholder = ->(text) { text.to_s.strip.empty? || text.to_s.include?('[Isi oleh') }

# Blok kontak dipakai bersama oleh kedua dokumen di tiap bahasa.
contact = {
  en: <<~HTML,
    <p><strong>PT Prisma Harapan (Prisma Advertising)</strong><br>
    Graha Prisma, Jl. Kedoya Duri Raya No. 38, Kedoya Selatan<br>
    Jakarta Barat 11520, Indonesia<br>
    Email: <a href="mailto:info@prisma-ads.com">info@prisma-ads.com</a><br>
    Phone: +62 21 5835 6570</p>
  HTML
  id: <<~HTML,
    <p><strong>PT Prisma Harapan (Prisma Advertising)</strong><br>
    Graha Prisma, Jl. Kedoya Duri Raya No. 38, Kedoya Selatan<br>
    Jakarta Barat 11520, Indonesia<br>
    Email: <a href="mailto:info@prisma-ads.com">info@prisma-ads.com</a><br>
    Telepon: +62 21 5835 6570</p>
  HTML
  cn: <<~HTML
    <p><strong>PT Prisma Harapan（Prisma Advertising）</strong><br>
    Graha Prisma, Jl. Kedoya Duri Raya No. 38, Kedoya Selatan<br>
    Jakarta Barat 11520, Indonesia（印度尼西亚）<br>
    电子邮件：<a href="mailto:info@prisma-ads.com">info@prisma-ads.com</a><br>
    电话：+62 21 5835 6570</p>
  HTML
}

privacy_en = <<~HTML
  <h2>1. Introduction</h2>
  <p>This Privacy Policy explains how PT Prisma Harapan ("Prisma Advertising", "Prisma", "we", "us") collects, uses, discloses, and protects personal data of visitors to prisma-ads.com (the "Website"), including when you contact us, apply for a job, or browse our billboard, campaign, and article pages.</p>
  <p>We are the controller of the personal data processed through the Website. We process personal data in accordance with Law No. 27 of 2022 on Personal Data Protection ("PDP Law") and other applicable Indonesian regulations. By using the Website and submitting your data through our forms, you acknowledge this Privacy Policy.</p>

  <h2>2. Data We Collect</h2>
  <h3>2.1 Data you provide to us</h3>
  <ul>
    <li><strong>Inquiry form:</strong> your name, company name, email address, phone number, subject, and message.</li>
    <li><strong>Job application form:</strong> your name, email address, phone number, the position you apply for, and the CV/résumé file you upload (PDF, DOC, or DOCX, up to 20 MB), including any personal data contained in that file.</li>
    <li><strong>Other communication:</strong> information you send us by email, phone, or WhatsApp.</li>
  </ul>
  <p>Please do not include sensitive information (for example health data, religion, or government ID numbers) in your message or CV unless we explicitly ask for it. We do not collect payment card details through the Website.</p>
  <h3>2.2 Data collected automatically</h3>
  <p>When you visit the Website, our servers and the technologies described in Section 6 automatically record technical data such as your IP address, browser type and version, device and operating system, pages viewed, referring page, and the date and time of your visit.</p>

  <h2>3. How We Use Your Data</h2>
  <ul>
    <li>To respond to your inquiry and, where relevant, prepare information or proposals about our outdoor (OOH) and digital out-of-home (DOOH) advertising services.</li>
    <li>To review job applications and communicate with applicants about the recruitment process.</li>
    <li>To protect the Website against spam, abuse, and fraud (including through Google reCAPTCHA), and to keep it secure and working properly.</li>
    <li>To understand how the Website is used and improve its content and performance.</li>
    <li>To comply with legal obligations and to establish, exercise, or defend legal claims.</li>
  </ul>
  <p>Depending on the situation, our legal bases are your consent (given when you submit a form), steps taken at your request before entering into an agreement, our legitimate interests in operating and securing the Website, and compliance with legal obligations.</p>

  <h2>4. Who We Share Your Data With</h2>
  <ul>
    <li><strong>Our internal teams</strong> (such as sales, marketing, and human resources) who need the data to handle your inquiry or application.</li>
    <li><strong>Service providers</strong> that help us run the Website, including an email delivery provider (Brevo, formerly Sendinblue) that delivers form notifications, including CV attachments, to our team; Google services described in Section 6; and hosting and infrastructure providers that store the Website's database and uploaded files.</li>
    <li><strong>Authorities and legal advisers</strong> where required by law, court order, or to protect our legal rights.</li>
    <li><strong>A successor entity</strong> if Prisma is involved in a merger, acquisition, or restructuring, subject to this Policy.</li>
  </ul>
  <p>We do not sell your personal data.</p>

  <h2>5. International Transfers</h2>
  <p>Some of our service providers, such as Google and Brevo, may process data on servers outside Indonesia. Where this happens, we take steps to ensure that your personal data receives protection that meets the requirements of the PDP Law.</p>

  <h2>6. Cookies and Similar Technologies</h2>
  <ul>
    <li><strong>Google Tag Manager</strong> is loaded on the Website. It loads tags, for example analytics or measurement tools, that may set cookies or collect data such as IP address, device information, and pages viewed.</li>
    <li><strong>Google reCAPTCHA</strong> analyses browser and interaction signals to tell humans from bots and may set cookies. It is subject to Google's Privacy Policy and Terms of Service.</li>
    <li><strong>Embedded content</strong> such as Google Maps (location pages), YouTube videos, and Google Fonts may cause your browser to connect to Google or YouTube servers, which can receive your IP address.</li>
  </ul>
  <p>You can block or delete cookies through your browser settings. If you block reCAPTCHA, our forms may not work. You can also use the opt-out tools provided by Google.</p>

  <h2>7. Data Retention</h2>
  <p>We keep personal data only for as long as necessary for the purposes described in this Policy. For example, inquiry details are kept while we handle your request and any resulting business relationship, application data is kept for the recruitment process and a reasonable period afterwards, and server logs are kept for a limited period. When data is no longer needed, we delete or anonymise it, unless the law requires us to keep it longer.</p>

  <h2>8. Security</h2>
  <p>We apply reasonable technical and organisational measures to protect personal data against unauthorised access, loss, or misuse. The Website is served over HTTPS and access to submitted data is limited to authorised personnel. No method of transmission or storage is completely secure. If a personal data protection failure occurs, we will notify you and the relevant authority within the period required by law.</p>

  <h2>9. Your Rights</h2>
  <p>Under the PDP Law you have the right to, among others:</p>
  <ul>
    <li>obtain information about, and a copy of, your personal data we process;</li>
    <li>correct or complete inaccurate personal data;</li>
    <li>request the deletion or destruction of your personal data;</li>
    <li>withdraw your consent, and object to or restrict certain processing;</li>
    <li>request that your data be transferred to another controller where applicable.</li>
  </ul>
  <p>To exercise these rights, email us at <a href="mailto:info@prisma-ads.com">info@prisma-ads.com</a>. We may need to verify your identity first, and we will respond within the time required by law.</p>

  <h2>10. Children</h2>
  <p>The Website is not directed to persons under 18 years of age, and we do not knowingly collect their personal data. If you believe a child has provided us with personal data, please contact us so that we can delete it.</p>

  <h2>11. Third-Party Links</h2>
  <p>The Website contains links to third-party services, such as our social media pages and WhatsApp. We are not responsible for the privacy practices of those third parties; please read their policies.</p>

  <h2>12. Changes to This Policy</h2>
  <p>We may update this Privacy Policy from time to time. The updated version is posted on this page, and the "Last updated" date shows when it was last changed. Please review it periodically.</p>

  <h2>13. Contact Us</h2>
  <p>If you have questions about this Privacy Policy or want to exercise your rights, contact:</p>
  #{contact[:en]}
HTML

privacy_id = <<~HTML
  <h2>1. Pendahuluan</h2>
  <p>Kebijakan Privasi ini menjelaskan bagaimana PT Prisma Harapan ("Prisma Advertising", "Prisma", "kami") mengumpulkan, menggunakan, mengungkapkan, dan melindungi data pribadi pengunjung situs prisma-ads.com ("Situs"), termasuk saat Anda menghubungi kami, melamar pekerjaan, atau menjelajahi halaman billboard, kampanye, dan artikel kami.</p>
  <p>Kami bertindak sebagai Pengendali Data Pribadi atas data pribadi yang diproses melalui Situs. Kami memproses data pribadi sesuai dengan Undang-Undang Nomor 27 Tahun 2022 tentang Pelindungan Data Pribadi ("UU PDP") dan peraturan perundang-undangan lain yang berlaku di Indonesia. Dengan menggunakan Situs dan mengirimkan data melalui formulir kami, Anda menyatakan telah mengetahui Kebijakan Privasi ini.</p>

  <h2>2. Data yang Kami Kumpulkan</h2>
  <h3>2.1 Data yang Anda berikan kepada kami</h3>
  <ul>
    <li><strong>Formulir inquiry:</strong> nama, nama perusahaan, alamat email, nomor telepon, subjek, dan pesan Anda.</li>
    <li><strong>Formulir lamaran kerja:</strong> nama, alamat email, nomor telepon, posisi yang dilamar, dan berkas CV/resume yang Anda unggah (PDF, DOC, atau DOCX, maksimal 20 MB), termasuk data pribadi apa pun yang tercantum di dalamnya.</li>
    <li><strong>Komunikasi lain:</strong> informasi yang Anda kirimkan melalui email, telepon, atau WhatsApp.</li>
  </ul>
  <p>Mohon tidak mencantumkan informasi sensitif (misalnya data kesehatan, agama, atau nomor identitas) dalam pesan atau CV Anda kecuali kami memintanya secara tegas. Kami tidak mengumpulkan data kartu pembayaran melalui Situs.</p>
  <h3>2.2 Data yang dikumpulkan secara otomatis</h3>
  <p>Saat Anda mengunjungi Situs, server kami dan teknologi yang dijelaskan pada Bagian 6 secara otomatis mencatat data teknis seperti alamat IP, jenis dan versi browser, perangkat dan sistem operasi, halaman yang dilihat, halaman perujuk, serta tanggal dan waktu kunjungan.</p>

  <h2>3. Penggunaan Data Anda</h2>
  <ul>
    <li>Menanggapi inquiry Anda dan, bila relevan, menyiapkan informasi atau proposal layanan iklan luar ruang (OOH) dan iklan luar ruang digital (DOOH) kami.</li>
    <li>Menyeleksi lamaran kerja dan berkomunikasi dengan pelamar mengenai proses rekrutmen.</li>
    <li>Melindungi Situs dari spam, penyalahgunaan, dan penipuan (termasuk melalui Google reCAPTCHA), serta menjaga keamanan dan kelancaran Situs.</li>
    <li>Memahami cara Situs digunakan dan meningkatkan konten serta kinerjanya.</li>
    <li>Memenuhi kewajiban hukum serta menetapkan, menjalankan, atau membela klaim hukum.</li>
  </ul>
  <p>Sesuai keadaannya, dasar pemrosesan kami adalah persetujuan Anda (diberikan saat mengirim formulir), langkah-langkah yang diambil atas permintaan Anda sebelum membuat perjanjian, kepentingan sah kami dalam mengoperasikan dan mengamankan Situs, serta pemenuhan kewajiban hukum.</p>

  <h2>4. Dengan Siapa Kami Membagikan Data Anda</h2>
  <ul>
    <li><strong>Tim internal kami</strong> (seperti penjualan, pemasaran, dan sumber daya manusia) yang membutuhkan data tersebut untuk menangani inquiry atau lamaran Anda.</li>
    <li><strong>Penyedia layanan</strong> yang membantu kami mengoperasikan Situs, termasuk penyedia pengiriman email (Brevo, sebelumnya Sendinblue) yang mengirimkan notifikasi formulir, termasuk lampiran CV, kepada tim kami; layanan Google yang dijelaskan pada Bagian 6; serta penyedia hosting dan infrastruktur yang menyimpan basis data dan berkas unggahan Situs.</li>
    <li><strong>Otoritas dan penasihat hukum</strong> bila diwajibkan oleh hukum, perintah pengadilan, atau untuk melindungi hak hukum kami.</li>
    <li><strong>Entitas penerus</strong> apabila Prisma terlibat dalam penggabungan, akuisisi, atau restrukturisasi, dengan tetap tunduk pada Kebijakan ini.</li>
  </ul>
  <p>Kami tidak menjual data pribadi Anda.</p>

  <h2>5. Transfer Data ke Luar Negeri</h2>
  <p>Sebagian penyedia layanan kami, seperti Google dan Brevo, dapat memproses data pada server di luar Indonesia. Dalam hal ini, kami mengupayakan agar data pribadi Anda memperoleh pelindungan yang memenuhi ketentuan UU PDP.</p>

  <h2>6. Cookie dan Teknologi Serupa</h2>
  <ul>
    <li><strong>Google Tag Manager</strong> dimuat di Situs. Layanan ini memuat tag, misalnya alat analitik atau pengukuran, yang dapat menyimpan cookie atau mengumpulkan data seperti alamat IP, informasi perangkat, dan halaman yang dilihat.</li>
    <li><strong>Google reCAPTCHA</strong> menganalisis sinyal browser dan interaksi untuk membedakan manusia dari bot dan dapat menyimpan cookie. Layanan ini tunduk pada Kebijakan Privasi dan Ketentuan Layanan Google.</li>
    <li><strong>Konten tertanam</strong> seperti Google Maps (halaman lokasi), video YouTube, dan Google Fonts dapat membuat browser Anda terhubung ke server Google atau YouTube, yang dapat menerima alamat IP Anda.</li>
  </ul>
  <p>Anda dapat memblokir atau menghapus cookie melalui pengaturan browser. Jika reCAPTCHA diblokir, formulir kami mungkin tidak berfungsi. Anda juga dapat menggunakan alat penolakan (opt-out) yang disediakan Google.</p>

  <h2>7. Penyimpanan Data</h2>
  <p>Kami menyimpan data pribadi hanya selama diperlukan untuk tujuan yang dijelaskan dalam Kebijakan ini. Misalnya, data inquiry disimpan selama kami menangani permintaan Anda dan hubungan bisnis yang timbul darinya, data lamaran disimpan selama proses rekrutmen dan jangka waktu wajar setelahnya, dan log server disimpan untuk jangka waktu terbatas. Bila data tidak lagi diperlukan, kami menghapus atau menganonimkannya, kecuali hukum mewajibkan penyimpanan lebih lama.</p>

  <h2>8. Keamanan</h2>
  <p>Kami menerapkan langkah teknis dan organisasi yang wajar untuk melindungi data pribadi dari akses tanpa izin, kehilangan, atau penyalahgunaan. Situs disajikan melalui HTTPS dan akses ke data yang dikirimkan dibatasi bagi personel yang berwenang. Tidak ada metode transmisi atau penyimpanan yang sepenuhnya aman. Apabila terjadi kegagalan pelindungan data pribadi, kami akan memberitahukan Anda dan otoritas terkait dalam jangka waktu yang diwajibkan oleh hukum.</p>

  <h2>9. Hak Anda</h2>
  <p>Berdasarkan UU PDP, Anda antara lain berhak untuk:</p>
  <ul>
    <li>memperoleh informasi dan salinan data pribadi Anda yang kami proses;</li>
    <li>memperbaiki atau melengkapi data pribadi yang tidak akurat;</li>
    <li>meminta penghapusan atau pemusnahan data pribadi Anda;</li>
    <li>menarik persetujuan Anda, serta menolak atau membatasi pemrosesan tertentu;</li>
    <li>meminta data Anda dipindahkan ke pengendali lain bila berlaku.</li>
  </ul>
  <p>Untuk menggunakan hak tersebut, kirim email ke <a href="mailto:info@prisma-ads.com">info@prisma-ads.com</a>. Kami dapat meminta verifikasi identitas Anda terlebih dahulu, dan akan menanggapi dalam jangka waktu yang diwajibkan oleh hukum.</p>

  <h2>10. Anak</h2>
  <p>Situs ini tidak ditujukan bagi orang berusia di bawah 18 tahun, dan kami tidak dengan sengaja mengumpulkan data pribadi mereka. Jika Anda yakin seorang anak telah memberikan data pribadinya kepada kami, silakan hubungi kami agar data tersebut dapat kami hapus.</p>

  <h2>11. Tautan Pihak Ketiga</h2>
  <p>Situs memuat tautan ke layanan pihak ketiga, seperti halaman media sosial kami dan WhatsApp. Kami tidak bertanggung jawab atas praktik privasi pihak ketiga tersebut; silakan baca kebijakan mereka.</p>

  <h2>12. Perubahan Kebijakan</h2>
  <p>Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu. Versi terbaru diterbitkan di halaman ini, dan tanggal "Terakhir diperbarui" menunjukkan kapan terakhir diubah. Mohon tinjau secara berkala.</p>

  <h2>13. Hubungi Kami</h2>
  <p>Jika Anda memiliki pertanyaan mengenai Kebijakan Privasi ini atau ingin menggunakan hak Anda, hubungi:</p>
  #{contact[:id]}
HTML

privacy_cn = <<~HTML
  <h2>1. 简介</h2>
  <p>本隐私政策说明 PT Prisma Harapan（“Prisma Advertising”、“Prisma”或“我们”）如何收集、使用、披露和保护 prisma-ads.com 网站（“本网站”）访问者的个人数据，包括您联系我们、申请职位或浏览我们的广告牌、案例和文章页面时的情形。</p>
  <p>我们是通过本网站处理的个人数据的控制者。我们依照印度尼西亚《2022年第27号个人数据保护法》（“个人数据保护法”）及其他适用的印度尼西亚法规处理个人数据。使用本网站并通过我们的表单提交数据，即表示您已知悉本隐私政策。</p>

  <h2>2. 我们收集的数据</h2>
  <h3>2.1 您向我们提供的数据</h3>
  <ul>
    <li><strong>咨询表单：</strong>您的姓名、公司名称、电子邮件地址、电话号码、主题和留言内容。</li>
    <li><strong>求职申请表单：</strong>您的姓名、电子邮件地址、电话号码、申请的职位，以及您上传的简历文件（PDF、DOC 或 DOCX，最大 20 MB），包括该文件中所含的任何个人数据。</li>
    <li><strong>其他沟通：</strong>您通过电子邮件、电话或 WhatsApp 发送给我们的信息。</li>
  </ul>
  <p>除非我们明确要求，请勿在留言或简历中包含敏感信息（例如健康数据、宗教信仰或身份证件号码）。我们不会通过本网站收集支付卡信息。</p>
  <h3>2.2 自动收集的数据</h3>
  <p>您访问本网站时，我们的服务器及第 6 条所述技术会自动记录技术数据，例如 IP 地址、浏览器类型和版本、设备和操作系统、浏览的页面、来源页面以及访问的日期和时间。</p>

  <h2>3. 我们如何使用您的数据</h2>
  <ul>
    <li>回复您的咨询，并在适当时提供有关我们户外（OOH）和数字户外（DOOH）广告服务的信息或方案。</li>
    <li>审核求职申请，并就招聘流程与申请人沟通。</li>
    <li>保护本网站免受垃圾信息、滥用和欺诈（包括通过 Google reCAPTCHA），并保持其安全和正常运行。</li>
    <li>了解本网站的使用情况，改进其内容和性能。</li>
    <li>履行法律义务，以及确立、行使或抗辩法律主张。</li>
  </ul>
  <p>视具体情况，我们处理数据的法律依据包括：您的同意（在您提交表单时给予）、应您的要求在订立协议前采取的步骤、我们运营和保障本网站安全的合法利益，以及履行法律义务。</p>

  <h2>4. 我们与谁共享您的数据</h2>
  <ul>
    <li><strong>我们的内部团队</strong>（如销售、市场和人力资源团队），他们需要这些数据来处理您的咨询或申请。</li>
    <li><strong>服务提供商</strong>，协助我们运营本网站，包括向我们的团队发送表单通知（含简历附件）的电子邮件发送服务商 Brevo（前身为 Sendinblue）；第 6 条所述的 Google 服务；以及存储本网站数据库和上传文件的托管及基础设施服务商。</li>
    <li><strong>主管机关和法律顾问</strong>，在法律、法院命令要求或为保护我们的合法权利时。</li>
    <li><strong>继受实体</strong>，如 Prisma 参与合并、收购或重组，且仍受本政策约束。</li>
  </ul>
  <p>我们不会出售您的个人数据。</p>

  <h2>5. 跨境传输</h2>
  <p>我们的部分服务提供商（如 Google 和 Brevo）可能在印度尼西亚境外的服务器上处理数据。发生这种情况时，我们会采取措施，确保您的个人数据获得符合个人数据保护法要求的保护。</p>

  <h2>6. Cookie 及类似技术</h2>
  <ul>
    <li><strong>Google Tag Manager</strong> 已加载于本网站。它会加载标签（例如分析或测量工具），这些标签可能设置 Cookie 或收集 IP 地址、设备信息和浏览页面等数据。</li>
    <li><strong>Google reCAPTCHA</strong> 通过分析浏览器和交互信号来区分人类与机器人，并可能设置 Cookie。其使用受 Google 隐私政策和服务条款约束。</li>
    <li><strong>嵌入内容</strong>，如 Google 地图（位置页面）、YouTube 视频和 Google 字体，可能使您的浏览器连接到 Google 或 YouTube 服务器，这些服务器可能获取您的 IP 地址。</li>
  </ul>
  <p>您可以通过浏览器设置阻止或删除 Cookie。如果您阻止 reCAPTCHA，我们的表单可能无法使用。您也可以使用 Google 提供的退出工具。</p>

  <h2>7. 数据保留</h2>
  <p>我们仅在实现本政策所述目的所必需的期间内保留个人数据。例如，咨询信息在我们处理您的请求及由此产生的业务关系期间保留；申请数据在招聘流程期间及其后的合理期限内保留；服务器日志仅保留有限期限。数据不再需要时，我们会将其删除或匿名化，法律要求更长保留期的除外。</p>

  <h2>8. 安全</h2>
  <p>我们采取合理的技术和组织措施，保护个人数据免遭未经授权的访问、丢失或滥用。本网站通过 HTTPS 提供服务，提交数据的访问权限仅限于获授权的人员。任何传输或存储方式都无法做到绝对安全。如发生个人数据保护失败事件，我们将在法律要求的期限内通知您和相关主管机关。</p>

  <h2>9. 您的权利</h2>
  <p>根据个人数据保护法，您享有包括但不限于以下权利：</p>
  <ul>
    <li>获取我们处理的您的个人数据的相关信息和副本；</li>
    <li>更正或补充不准确的个人数据；</li>
    <li>要求删除或销毁您的个人数据；</li>
    <li>撤回您的同意，并反对或限制特定处理；</li>
    <li>在适用时，要求将您的数据转移给其他控制者。</li>
  </ul>
  <p>如需行使上述权利，请发送电子邮件至 <a href="mailto:info@prisma-ads.com">info@prisma-ads.com</a>。我们可能需要先核实您的身份，并将在法律要求的期限内回复。</p>

  <h2>10. 儿童</h2>
  <p>本网站不面向 18 岁以下人士，我们不会故意收集其个人数据。如果您认为有儿童向我们提供了个人数据，请联系我们，以便我们将其删除。</p>

  <h2>11. 第三方链接</h2>
  <p>本网站包含指向第三方服务的链接，例如我们的社交媒体页面和 WhatsApp。我们不对这些第三方的隐私做法负责，请阅读其相关政策。</p>

  <h2>12. 政策变更</h2>
  <p>我们可能不时更新本隐私政策。更新后的版本将发布在本页面，“最后更新”日期显示最近一次修改的时间。请定期查阅。</p>

  <h2>13. 联系我们</h2>
  <p>如果您对本隐私政策有疑问，或希望行使您的权利，请联系：</p>
  #{contact[:cn]}
HTML

terms_en = <<~HTML
  <h2>1. Acceptance of Terms</h2>
  <p>These Terms and Conditions ("Terms") govern your access to and use of prisma-ads.com (the "Website"), operated by PT Prisma Harapan ("Prisma Advertising", "Prisma", "we", "us"). By accessing or using the Website, you agree to these Terms and to our <a href="/privacy-policy">Privacy Policy</a>. If you do not agree, please do not use the Website.</p>

  <h2>2. Use of the Website</h2>
  <p>You may use the Website only for lawful purposes and in accordance with these Terms. You agree not to:</p>
  <ul>
    <li>use bots, scrapers, or other automated means to extract content or data from the Website without our written permission;</li>
    <li>submit false, misleading, or spam content through our forms, or submit data about another person without their authority;</li>
    <li>attempt to gain unauthorised access to, disrupt, or overload the Website or its servers, or bypass its security measures, including reCAPTCHA;</li>
    <li>upload malicious code, or use the Website in a way that violates applicable law or the rights of others.</li>
  </ul>
  <p>We may suspend or restrict access to the Website at any time, including for maintenance or security reasons.</p>

  <h2>3. Information on the Website</h2>
  <p>The Website describes our outdoor (OOH) and digital out-of-home (DOOH) advertising services, billboard and videotron locations, campaigns, and articles. This content is provided for general information. Availability of media locations, sizes, specifications, estimated impressions or audience figures, and prices may change and are not an offer. They become binding only through a written quotation, proposal, or agreement signed or confirmed by Prisma.</p>

  <h2>4. Inquiries and Advertising Services</h2>
  <ul>
    <li>Sending an inquiry through the Website does not create a contract or reserve any media location.</li>
    <li>Advertising services are provided under a separate written agreement, which sets out the price, term, specifications, and payment terms.</li>
    <li>All advertising materials must comply with applicable law, including advertising and outdoor-signage regulations and local permit requirements. We may refuse, require changes to, or remove any material that we reasonably consider unlawful, misleading, offensive, or in breach of third-party rights or permit conditions.</li>
  </ul>

  <h2>5. Intellectual Property</h2>
  <p>The Website, including its text, graphics, photographs, videos, layout, and trademarks (including "Prisma"), is owned by or licensed to Prisma and is protected by intellectual property laws. You may view and share links to the Website for personal or internal business purposes, but you may not copy, reproduce, modify, distribute, or use its content commercially without our written permission.</p>
  <p>Names, logos, and campaign materials of our clients shown in our portfolio belong to their respective owners and are displayed for reference only. No licence to them is granted to you.</p>

  <h2>6. Information You Submit</h2>
  <p>You are responsible for the accuracy of the information you submit through our forms. You grant us a limited right to use that information to respond to your inquiry or application and to operate the Website, as described in our Privacy Policy.</p>

  <h2>7. Third-Party Links and Services</h2>
  <p>The Website may link to or embed third-party services, such as Google Maps, YouTube, social media, and WhatsApp. These are provided for convenience, are governed by the third parties' own terms, and are outside our control. We are not responsible for their content or practices.</p>

  <h2>8. Disclaimer of Warranties</h2>
  <p>The Website is provided "as is" and "as available". To the fullest extent permitted by law, we do not warrant that the Website will be uninterrupted, error-free, or free of harmful components, or that its content is complete, accurate, or current.</p>

  <h2>9. Limitation of Liability</h2>
  <p>To the fullest extent permitted by law, Prisma and its directors, employees, and affiliates are not liable for any indirect, incidental, special, or consequential loss, or for loss of profit, revenue, or data, arising from your use of, or inability to use, the Website or from reliance on its content. Nothing in these Terms limits liability that cannot be limited under applicable law. The terms of any advertising service are governed by the separate agreement signed with the client.</p>

  <h2>10. Indemnification</h2>
  <p>You agree to indemnify and hold Prisma harmless from claims, losses, and expenses (including reasonable legal fees) arising from your breach of these Terms or your misuse of the Website.</p>

  <h2>11. Changes to These Terms</h2>
  <p>We may revise these Terms from time to time. The updated version is posted on this page, and the "Last updated" date shows when it was last changed. Continued use of the Website after an update means you accept the revised Terms.</p>

  <h2>12. Governing Law and Disputes</h2>
  <p>These Terms are governed by the laws of the Republic of Indonesia, including Law No. 11 of 2008 on Electronic Information and Transactions and its amendments. The parties will first try to resolve any dispute amicably through discussion. If it cannot be resolved, the dispute will be submitted to the exclusive jurisdiction of the West Jakarta District Court.</p>

  <h2>13. Contact Us</h2>
  <p>If you have questions about these Terms, contact:</p>
  #{contact[:en]}
HTML

terms_id = <<~HTML
  <h2>1. Penerimaan Ketentuan</h2>
  <p>Syarat dan Ketentuan ini ("Ketentuan") mengatur akses dan penggunaan Anda atas prisma-ads.com ("Situs"), yang dioperasikan oleh PT Prisma Harapan ("Prisma Advertising", "Prisma", "kami"). Dengan mengakses atau menggunakan Situs, Anda menyetujui Ketentuan ini dan <a href="/id/privacy-policy">Kebijakan Privasi</a> kami. Jika Anda tidak setuju, mohon tidak menggunakan Situs.</p>

  <h2>2. Penggunaan Situs</h2>
  <p>Anda hanya boleh menggunakan Situs untuk tujuan yang sah dan sesuai dengan Ketentuan ini. Anda setuju untuk tidak:</p>
  <ul>
    <li>menggunakan bot, scraper, atau cara otomatis lain untuk mengambil konten atau data dari Situs tanpa izin tertulis dari kami;</li>
    <li>mengirimkan konten palsu, menyesatkan, atau spam melalui formulir kami, atau mengirimkan data orang lain tanpa kewenangan;</li>
    <li>mencoba memperoleh akses tanpa izin ke, mengganggu, atau membebani Situs atau servernya, atau menghindari langkah keamanannya, termasuk reCAPTCHA;</li>
    <li>mengunggah kode berbahaya, atau menggunakan Situs dengan cara yang melanggar hukum yang berlaku atau hak pihak lain.</li>
  </ul>
  <p>Kami dapat menangguhkan atau membatasi akses ke Situs kapan saja, termasuk untuk alasan pemeliharaan atau keamanan.</p>

  <h2>3. Informasi di Situs</h2>
  <p>Situs memuat uraian layanan iklan luar ruang (OOH) dan iklan luar ruang digital (DOOH) kami, lokasi billboard dan videotron, kampanye, serta artikel. Konten ini disediakan sebagai informasi umum. Ketersediaan lokasi media, ukuran, spesifikasi, perkiraan impresi atau jumlah audiens, dan harga dapat berubah serta bukan merupakan penawaran. Hal-hal tersebut baru mengikat melalui penawaran, proposal, atau perjanjian tertulis yang ditandatangani atau dikonfirmasi oleh Prisma.</p>

  <h2>4. Inquiry dan Layanan Periklanan</h2>
  <ul>
    <li>Pengiriman inquiry melalui Situs tidak menimbulkan kontrak dan tidak mengamankan (reservasi) lokasi media apa pun.</li>
    <li>Layanan periklanan diberikan berdasarkan perjanjian tertulis tersendiri yang mengatur harga, jangka waktu, spesifikasi, dan ketentuan pembayaran.</li>
    <li>Seluruh materi iklan harus mematuhi hukum yang berlaku, termasuk peraturan periklanan dan reklame luar ruang serta persyaratan perizinan daerah. Kami dapat menolak, meminta perubahan, atau menurunkan materi yang menurut pertimbangan wajar kami melanggar hukum, menyesatkan, menyinggung, atau melanggar hak pihak ketiga maupun ketentuan izin.</li>
  </ul>

  <h2>5. Hak Kekayaan Intelektual</h2>
  <p>Situs, termasuk teks, grafis, foto, video, tata letak, dan merek dagangnya (termasuk "Prisma"), dimiliki oleh atau dilisensikan kepada Prisma dan dilindungi oleh hukum kekayaan intelektual. Anda boleh melihat dan membagikan tautan ke Situs untuk keperluan pribadi atau bisnis internal, tetapi tidak boleh menyalin, memperbanyak, mengubah, mendistribusikan, atau menggunakan kontennya secara komersial tanpa izin tertulis dari kami.</p>
  <p>Nama, logo, dan materi kampanye klien kami yang ditampilkan dalam portofolio adalah milik pemiliknya masing-masing dan ditampilkan hanya sebagai referensi. Tidak ada lisensi atas materi tersebut yang diberikan kepada Anda.</p>

  <h2>6. Informasi yang Anda Kirimkan</h2>
  <p>Anda bertanggung jawab atas keakuratan informasi yang Anda kirimkan melalui formulir kami. Anda memberi kami hak terbatas untuk menggunakan informasi tersebut guna menanggapi inquiry atau lamaran Anda dan mengoperasikan Situs, sebagaimana dijelaskan dalam Kebijakan Privasi kami.</p>

  <h2>7. Tautan dan Layanan Pihak Ketiga</h2>
  <p>Situs dapat memuat tautan atau menanamkan layanan pihak ketiga, seperti Google Maps, YouTube, media sosial, dan WhatsApp. Layanan tersebut disediakan demi kemudahan, tunduk pada ketentuan pihak ketiga masing-masing, dan berada di luar kendali kami. Kami tidak bertanggung jawab atas konten atau praktiknya.</p>

  <h2>8. Penafian Jaminan</h2>
  <p>Situs disediakan "sebagaimana adanya" dan "sebagaimana tersedia". Sejauh diizinkan oleh hukum, kami tidak menjamin bahwa Situs akan selalu tersedia tanpa gangguan, bebas dari kesalahan atau komponen berbahaya, ataupun bahwa kontennya lengkap, akurat, atau terkini.</p>

  <h2>9. Batasan Tanggung Jawab</h2>
  <p>Sejauh diizinkan oleh hukum, Prisma beserta direksi, karyawan, dan afiliasinya tidak bertanggung jawab atas kerugian tidak langsung, insidental, khusus, atau konsekuensial, maupun kehilangan keuntungan, pendapatan, atau data, yang timbul dari penggunaan atau ketidakmampuan menggunakan Situs atau dari ketergantungan pada kontennya. Tidak ada ketentuan dalam Ketentuan ini yang membatasi tanggung jawab yang menurut hukum yang berlaku tidak dapat dibatasi. Ketentuan setiap layanan periklanan diatur dalam perjanjian tersendiri yang ditandatangani dengan klien.</p>

  <h2>10. Ganti Rugi</h2>
  <p>Anda setuju untuk mengganti rugi dan membebaskan Prisma dari klaim, kerugian, dan biaya (termasuk biaya hukum yang wajar) yang timbul akibat pelanggaran Anda terhadap Ketentuan ini atau penyalahgunaan Situs oleh Anda.</p>

  <h2>11. Perubahan Ketentuan</h2>
  <p>Kami dapat merevisi Ketentuan ini dari waktu ke waktu. Versi terbaru diterbitkan di halaman ini, dan tanggal "Terakhir diperbarui" menunjukkan kapan terakhir diubah. Penggunaan Situs yang berlanjut setelah pembaruan berarti Anda menerima Ketentuan yang telah direvisi.</p>

  <h2>12. Hukum yang Berlaku dan Penyelesaian Sengketa</h2>
  <p>Ketentuan ini diatur oleh hukum Republik Indonesia, termasuk Undang-Undang Nomor 11 Tahun 2008 tentang Informasi dan Transaksi Elektronik beserta perubahannya. Para pihak akan lebih dahulu berupaya menyelesaikan sengketa secara musyawarah. Apabila tidak tercapai penyelesaian, sengketa akan diajukan kepada yurisdiksi eksklusif Pengadilan Negeri Jakarta Barat.</p>

  <h2>13. Hubungi Kami</h2>
  <p>Jika Anda memiliki pertanyaan mengenai Ketentuan ini, hubungi:</p>
  #{contact[:id]}
HTML

terms_cn = <<~HTML
  <h2>1. 条款的接受</h2>
  <p>本条款和条件（“条款”）适用于您访问和使用由 PT Prisma Harapan（“Prisma Advertising”、“Prisma”或“我们”）运营的 prisma-ads.com 网站（“本网站”）。访问或使用本网站，即表示您同意本条款以及我们的<a href="/cn/privacy-policy">隐私政策</a>。如不同意，请勿使用本网站。</p>

  <h2>2. 网站的使用</h2>
  <p>您只能出于合法目的并按照本条款使用本网站。您同意不得：</p>
  <ul>
    <li>未经我们书面许可，使用机器人、爬虫或其他自动化手段从本网站提取内容或数据；</li>
    <li>通过我们的表单提交虚假、误导性或垃圾内容，或在未获授权的情况下提交他人的数据；</li>
    <li>试图未经授权访问、干扰或使本网站及其服务器过载，或绕过其安全措施（包括 reCAPTCHA）；</li>
    <li>上传恶意代码，或以违反适用法律或侵犯他人权利的方式使用本网站。</li>
  </ul>
  <p>我们可随时暂停或限制对本网站的访问，包括出于维护或安全原因。</p>

  <h2>3. 网站信息</h2>
  <p>本网站介绍我们的户外（OOH）和数字户外（DOOH）广告服务、广告牌和视频屏幕点位、案例及文章。这些内容仅供一般参考。媒体点位的可用性、尺寸、规格、预计曝光量或受众数据以及价格可能变动，且不构成要约。只有经 Prisma 签署或确认的书面报价、方案或协议才具有约束力。</p>

  <h2>4. 咨询与广告服务</h2>
  <ul>
    <li>通过本网站提交咨询不构成合同，也不保留任何媒体点位。</li>
    <li>广告服务依据另行签订的书面协议提供，协议将约定价格、期限、规格和付款条款。</li>
    <li>所有广告素材必须遵守适用法律，包括广告和户外广告牌法规以及地方许可要求。对于我们合理认为违法、具有误导性、冒犯性，或侵犯第三方权利或违反许可条件的素材，我们可拒绝、要求修改或撤下。</li>
  </ul>

  <h2>5. 知识产权</h2>
  <p>本网站，包括其文字、图形、照片、视频、版式和商标（包括“Prisma”），归 Prisma 所有或已获许可，并受知识产权法保护。您可出于个人或内部业务目的浏览并分享指向本网站的链接，但未经我们书面许可，不得复制、转载、修改、分发或商业性使用其内容。</p>
  <p>作品集中展示的客户名称、标识和案例素材归其各自所有者所有，仅供参考展示。我们不向您授予这些内容的任何许可。</p>

  <h2>6. 您提交的信息</h2>
  <p>您应对通过我们的表单提交的信息的准确性负责。您授予我们有限的权利，按照我们隐私政策所述，使用这些信息来回复您的咨询或申请并运营本网站。</p>

  <h2>7. 第三方链接和服务</h2>
  <p>本网站可能链接或嵌入第三方服务，例如 Google 地图、YouTube、社交媒体和 WhatsApp。这些服务为方便而提供，受第三方自身条款约束，且不在我们的控制范围内。我们不对其内容或做法负责。</p>

  <h2>8. 免责声明</h2>
  <p>本网站按“现状”和“可用”状态提供。在法律允许的最大范围内，我们不保证本网站不间断、无错误或不含有害组件，也不保证其内容完整、准确或最新。</p>

  <h2>9. 责任限制</h2>
  <p>在法律允许的最大范围内，对于因您使用或无法使用本网站，或依赖其内容而产生的任何间接、附带、特殊或后果性损失，以及利润、收入或数据的损失，Prisma 及其董事、员工和关联方不承担责任。本条款的任何内容均不限制依适用法律不可限制的责任。任何广告服务的条款由与客户签订的另行协议约定。</p>

  <h2>10. 赔偿</h2>
  <p>因您违反本条款或滥用本网站而引起的索赔、损失和费用（包括合理的律师费），您同意向 Prisma 作出赔偿并使其免受损害。</p>

  <h2>11. 条款变更</h2>
  <p>我们可能不时修订本条款。更新后的版本将发布在本页面，“最后更新”日期显示最近一次修改的时间。更新后您继续使用本网站，即表示接受修订后的条款。</p>

  <h2>12. 适用法律与争议解决</h2>
  <p>本条款受印度尼西亚共和国法律管辖，包括《2008年第11号关于电子信息和交易的法律》及其修订。双方应首先通过协商友好解决争议。协商不成的，争议提交西雅加达地方法院专属管辖。</p>

  <h2>13. 联系我们</h2>
  <p>如果您对本条款有疑问，请联系：</p>
  #{contact[:cn]}
HTML

pages = [
  {
    title: 'Privacy Policy',
    slug: 'privacy-policy',
    meta_title: {
      en: 'Privacy Policy | Prisma Advertising',
      id: 'Kebijakan Privasi | Prisma Advertising',
      cn: '隐私政策 | Prisma Advertising'
    },
    meta_description: {
      en: 'How Prisma Advertising collects, uses, and protects your personal data when you use our website, send an inquiry, or apply for a job.',
      id: 'Bagaimana Prisma Advertising mengumpulkan, menggunakan, dan melindungi data pribadi Anda saat menggunakan situs, mengirim inquiry, atau melamar pekerjaan.',
      cn: '了解 Prisma Advertising 在您使用本网站、提交咨询或申请职位时，如何收集、使用和保护您的个人数据。'
    },
    content: { en: privacy_en, id: privacy_id, cn: privacy_cn }
  },
  {
    title: 'Terms & Conditions',
    slug: 'terms',
    meta_title: {
      en: 'Terms & Conditions | Prisma Advertising',
      id: 'Syarat & Ketentuan | Prisma Advertising',
      cn: '条款和条件 | Prisma Advertising'
    },
    meta_description: {
      en: 'Terms governing the use of the Prisma Advertising website, billboard information, and inquiries about our outdoor advertising services.',
      id: 'Ketentuan penggunaan situs Prisma Advertising, informasi billboard, dan inquiry layanan iklan luar ruang kami.',
      cn: '使用 Prisma Advertising 网站、广告牌信息以及咨询我们户外广告服务的相关条款。'
    },
    content: { en: terms_en, id: terms_id, cn: terms_cn }
  }
]

locale_names = { en: 'EN', id: 'ID', cn: 'CN' }

pages.each do |attrs|
  next if only.any? && !only.include?(attrs[:slug])

  page = Page.find_by(slug: attrs[:slug]) || Page.find_by(title: attrs[:title])
  created = page.nil?
  page ||= Page.new(title: attrs[:title], status: 0, published_date: Time.current)
  written = []
  skipped = []

  locales.each do |locale|
    Mobility.with_locale(locale) do
      # fallback: false wajib. Tanpa itu, membaca :id/:cn yang kosong mengembalikan teks :en
      # (fallbacks id/cn -> en di config/initializers/mobility.rb), sehingga dianggap sudah terisi.
      current = page.new_record? ? nil : page.content(fallback: false)
      current_text = current.respond_to?(:to_plain_text) ? current.to_plain_text : current.to_s

      if force || placeholder.call(current_text)
        page.content = attrs[:content][locale]
        written << locale_names[locale]
      else
        skipped << locale_names[locale]
      end

      # Meta ada di seo_settings (form "SEO & Social"), bukan kolom model. Dibaca tanpa fallback
      # agar teks EN tidak dianggap terisi oleh teks ID.
      seo = page.seo_setting || page.build_seo_setting
      if force || seo.new_record? || seo.meta_title(fallback: false).to_s.strip.empty?
        seo.meta_title = attrs[:meta_title][locale]
      end
      if force || seo.new_record? || seo.meta_description(fallback: false).to_s.strip.empty?
        seo.meta_description = attrs[:meta_description][locale]
      end
    end
  end

  page.status = publish ? 1 : 0 if written.any? || created
  page.published_date ||= Time.current
  page.save!

  # URL legal ditetapkan client; FriendlyId membangkitkan slug dari judul, jadi dipaksa setelah save.
  page.update_columns(slug: attrs[:slug]) if page.slug != attrs[:slug]

  state = page.status == 1 ? 'Published' : 'Draft'
  action = created ? 'Dibuat' : (written.any? ? 'Diperbarui' : 'Tanpa perubahan')
  puts "#{action} '#{page.title}' (/#{page.slug}) — status #{state}; " \
       "konten ditulis: #{written.join(', ').presence || '-'}; dilewati (sudah diedit): #{skipped.join(', ').presence || '-'}"
end

puts 'Selesai. Teks ini draf standar; minta tim legal Prisma meninjau sebelum dianggap final.'
