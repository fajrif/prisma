# T15: CSS tema (±1 MB mentah, ±154 KB gzip) hanya ±9% yang dipakai halaman publik. Task ini membuat versi
# yang sudah dipangkas (vendor/assets/stylesheets/*.purged.css) yang dimuat application.css.
#
# Jalankan ulang (lokal, lalu commit hasilnya) setiap kali: menambah/mengubah view atau kelas CSS di view,
# mengubah CSS tema di vendor/assets/stylesheets, atau mengisi kelas baru di field CMS (css_class/bg_color
# Section & Snippet) yang belum pernah dipakai. Butuh Node (npx). Server tidak perlu menjalankannya.
namespace :css do
	desc "Pangkas CSS tema yang tidak dipakai halaman publik (PurgeCSS) -> vendor/assets/stylesheets/*.purged.css"
	task purge: :environment do
		require "fileutils"

		dir = Rails.root.join("tmp/purgecss")
		FileUtils.rm_rf(dir)
		FileUtils.mkdir_p(dir.join("html"))

		session = ActionDispatch::Integration::Session.new(Rails.application)
		session.host = "localhost"
		fetch = lambda do |path|
			session.get(path)
			session.response
		end

		# Semua URL di sitemap (3 bahasa) + halaman yang tidak masuk sitemap.
		paths = []
		index = fetch.call("/sitemap.xml").body
		index.scan(%r{<loc>([^<]+)</loc>}).flatten.each do |sitemap|
			fetch.call(URI(sitemap).path).body.scan(%r{<loc>([^<]+)</loc>}).flatten.each { |loc| paths << URI(loc).request_uri }
		end
		paths += %w[/404 /500 /articles?page=2 /campaigns?page=2 /locations/jakarta?billboard_type=static]
		paths.uniq!

		failed = []
		paths.each_with_index do |path, i|
			res = fetch.call(path)
			if res.status == 200 || path.match?(%r{\A/(404|500)\z})
				File.write(dir.join("html", format("%04d.html", i)), res.body)
			else
				failed << "#{path} (#{res.status})"
			end
		end
		puts "#{paths.size - failed.size} halaman dirender" + (failed.any? ? ", gagal: #{failed.first(10).join(', ')}" : "")

		# Kelas dari CMS (termasuk yang belum tampil di halaman mana pun).
		db = [
			Section.unscoped.pluck(:bg_color, :css_class),
			Snippet.unscoped.pluck(:bg_color, :css_class, :text_color, :orientation)
		].flatten.compact_blank.uniq
		File.write(dir.join("db.txt"), db.join("\n"))

		out = dir.join("out")
		FileUtils.mkdir_p(out)
		ok = system("npx", "--yes", "purgecss@6.0.0", "--config", "config/purgecss.config.js", "--output", out.to_s,
		            chdir: Rails.root.to_s)
		abort "PurgeCSS gagal" unless ok

		header = "/* DIBUAT OTOMATIS oleh `bin/rails css:purge` dari %s. Jangan diedit: ubah file aslinya lalu jalankan ulang task. */\n"
		Dir[out.join("*.css")].sort.each do |file|
			name = File.basename(file, ".css")
			src = Rails.root.join("vendor/assets/stylesheets", "#{name}.css")
			dest = Rails.root.join("vendor/assets/stylesheets", "#{name}.purged.css")
			File.write(dest, format(header, File.basename(src)) + File.read(file))
			puts format("%-26s %8d -> %8d byte", File.basename(src), File.size(src), File.size(dest))
		end
	end
end
