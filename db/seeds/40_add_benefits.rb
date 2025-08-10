Benefit.delete_all

arr = [
  { en: "High visibility, 24 hours a day", id: "Visibilitas tinggi, terlihat 24 jam sehari" },
  { en: "Clear, focused messaging with no rotation", id: "Pesan yang jelas dan fokus tanpa rotasi" },
  { en: "Strategic placement in key urban locations", id: "Penempatan strategis di lokasi urban utama" },
  { en: "Full creative control with maximum format flexibility", id: "Kontrol kreatif penuh dengan fleksibilitas format maksimal" }
]

# Benefit Static Billboard Advertising
arr.each do |b|
  ben = Benefit.new(content: b[:en], service: @srv1)
  Mobility.with_locale(:id) {
    ben.content = b[:id]
  }
  ben.save
  puts "Add Benefit Service: #{@srv1.name} -> #{ben.content}"
end

arr = [
  { en: "High visibility in key urban areas", id: "Visibilitas tinggi di area perkotaan utama" },
  { en: "Multiple creatives in one day", id: "Beberapa materi iklan dalam satu hari" },
  { en: "Real-time updates without reprinting", id: "Pembaruan real-time tanpa perlu cetak ulang" },
  { en: "Dynamic content that commands attention", id: "Konten dinamis yang langsung menarik perhatian" },
  { en: "Seamless integration with data and targeting tools", id: "Integrasi mudah dengan data dan alat penargetan" }
]

# Digital Billboard Advertising
arr.each do |b|
  ben = Benefit.new(content: b[:en], service: @srv2)
  Mobility.with_locale(:id) {
    ben.content = b[:id]
  }
  ben.save
  puts "Add Benefit Service: #{@srv2.name} -> #{ben.content}"
end

arr = [
  { en: "Bold, oversized builds that break the frame", id: "Visibilitas tinggi di pusat perbelanjaan dan area perkantoran" },
  { en: "Unmissable presence in high-traffic urban zones", id: "Terintegrasi langsung dalam aktivitas urban masyarakat" },
  { en: "Real-world engagement through scale and form", id: "Format iklan OOH kreatif yang mencuri perhatian" },
  { en: "Immersive storytelling that sparks curiosity", id: "Pengalaman nyata yang memperkuat brand recall" }
]

# Creative OOH Branding
arr.each do |b|
  ben = Benefit.new(content: b[:en], service: @srv3)
  Mobility.with_locale(:id) {
    ben.content = b[:id]
  }
  ben.save
  puts "Add Benefit Service: #{@srv3.name} -> #{ben.content}"
end

arr = [
  { en: "Unmissable visibility in high-traffic urban zones", id: "Visibilitas tinggi di area dengan mobilitas padat" },
  { en: "Continuous exposure from both mobile and static formats", id: "Tayangan berulang dari media bergerak maupun statis" },
  { en: "Cost-effective reach with high impression frequency", id: "Efektif secara biaya dan sulit untuk diabaikan" },
  { en: "Built-in integration with daily commuter journeys", id: "Terintegrasi dengan rutinitas sehari-hari komuter" },
  { en: "Flexible options: from full bus branding to terminal takeovers", id: "Format fleksibel: dari bus branding hingga takeover terminal" }
]

# Transit Media
arr.each do |b|
  ben = Benefit.new(content: b[:en], service: @srv4)
  Mobility.with_locale(:id) {
    ben.content = b[:id]
  }
  ben.save
  puts "Add Benefit Service: #{@srv4.name} -> #{ben.content}"
end

arr = [
  { en: "Real-time monitoring of all OOH advertising placements", id: "Visibilitas real-time atas semua titik media OOH" },
  { en: "Centralized control across static, digital, and transit media", id: "Kontrol terpusat untuk media statis, digital, dan transportasi" },
  { en: "Easy access to performance data and optimization tools", id: "Akses mudah ke data performa dan alat optimasi" },
  { en: "Improved accountability and faster decision-making", id: "Transparansi lebih tinggi untuk pengambilan keputusan cepat" },
  { en: "Seamless collaboration with brands, agencies, and media partners", id: "Kolaborasi mulus antara brand, agensi, dan mitra media" }
]

# OOH Media Dashboard Access
arr.each do |b|
  ben = Benefit.new(content: b[:en], service: @srv5)
  Mobility.with_locale(:id) {
    ben.content = b[:id]
  }
  ben.save
  puts "Add Benefit Service: #{@srv5.name} -> #{ben.content}"
end
