# Tanggal perubahan konten yang nyata, dipakai bersama oleh `lastmod` di sitemap,
# `dateModified` di schema, dan label "Diperbarui" di halaman. Satu sumber supaya
# ketiganya tidak pernah saling berbeda.
#
# Dihitung saat diminta, bukan disimpan: nilai tersimpan bisa basi bila relasinya
# berubah, sedangkan nilai terhitung tidak.
#
# Article dan Portfolio meng-override ini dengan tanggal yang diatur admin
# (`modified_date`), karena updated_at mereka sering bergeser oleh simpan ulang
# yang hanya merapikan tampilan. Model lain tetap memakai updated_at.
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
