# Helper khusus halaman lokasi/hub (locations, areas).
module LocationsHelper
  # Ukuran terbesar di antara titik-titik lokasi, dari kolom products.size dengan format
  # "20m (h) x 35m (w)" (juga "128cm (h) x 64cm (w)"). Mengembalikan [lebar, tinggi] dalam
  # meter (mis. [35, 20]) atau nil bila tidak ada ukuran yang terbaca — dipakai kotak
  # "Ukuran hingga …" pada key facts hub (sheet SEO 19 Oct).
  def max_billboard_size_meters(products)
    candidates = products.filter_map do |product|
      match = product.size.to_s.match(/(\d+(?:[.,]\d+)?)\s*(cm|m)?\s*\(h\)\s*x\s*(\d+(?:[.,]\d+)?)\s*(cm|m)?\s*\(w\)/i)
      next unless match

      height = match[1].tr(',', '.').to_f
      width = match[3].tr(',', '.').to_f
      # cm → meter agar satu satuan sebelum dibandingkan.
      height /= 100.0 if match[2].to_s.downcase == 'cm'
      width /= 100.0 if match[4].to_s.downcase == 'cm'
      next unless height.positive? && width.positive?

      [width, height]
    end
    candidates.max_by { |width, height| width * height }
  end

  # Teks "20 × 35 m" — tinggi × lebar, mengikuti format kolom size & copy sheet ("20 × 35 m"
  # untuk "20m (h) x 35m (w)"); bilangan bulat tanpa pecahan.
  def billboard_size_label(width, height)
    format_size = ->(value) { value == value.to_i ? value.to_i.to_s : value.to_s }
    "#{format_size.call(height)} × #{format_size.call(width)} m"
  end
end
