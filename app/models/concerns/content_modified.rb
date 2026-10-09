# Tanggal perubahan konten yang nyata, dipakai bersama oleh `lastmod` di sitemap,
# `dateModified` di schema, dan label "Diperbarui" di halaman. Satu sumber supaya
# ketiganya tidak pernah saling berbeda.
#
# Dihitung saat diminta, bukan disimpan: nilai tersimpan bisa basi bila relasinya
# berubah, sedangkan nilai terhitung tidak.
#
# Aturan internal: tanggal tidak boleh dimajukan tanpa pembaruan konten. Jangan
# memanggil `touch` massal dari rake/script; backfill memakai `update_columns`,
# yang memang tidak mengubah `updated_at`.
module ContentModified
	extend ActiveSupport::Concern

	def content_modified_at
		[updated_at, *related_modified_at].compact.max
	end

	private

	# Override di model yang kontennya juga datang dari relasi.
	def related_modified_at
		[]
	end
end
