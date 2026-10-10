// Penghitung panjang meta title/description di form "SEO & Social" (admins/shared/_seo_fields).
// Peringatan LUNAK: tidak pernah menahan penyimpanan. Field kosong = situs memakai nilai otomatis,
// jadi yang dihitung adalah nilai otomatis itu (data-auto).
(function () {
	function describe(length, min, max) {
		if (length > max) return { cls: 'text-danger', text: 'terlalu panjang, ' + (length - max) + ' karakter terpotong di hasil pencarian' };
		if (length < min) return { cls: 'text-warning', text: 'terlalu pendek, ideal minimal ' + min };
		return { cls: 'text-success', text: 'panjang pas' };
	}

	function init(input) {
		var min = parseInt(input.dataset.min, 10), max = parseInt(input.dataset.max, 10);
		var auto = input.dataset.auto || '';
		var out = document.createElement('div');
		out.className = 'seo-counter small mt-1';
		out.setAttribute('aria-live', 'polite');
		var anchor = input.closest('.form-group, .mb-3, div') || input;
		anchor.appendChild(out);

		function update() {
			var typed = input.value.trim();
			var automatic = typed === '';
			var length = (automatic ? auto : typed).length;
			var d = describe(length, min, max);
			out.className = 'seo-counter small mt-1 ' + d.cls;
			out.textContent = length + ' / ' + max + ' karakter' + (automatic ? ' (otomatis)' : '') + ' — ' + d.text;
		}

		input.addEventListener('input', update);
		update();
	}

	document.addEventListener('DOMContentLoaded', function () {
		document.querySelectorAll('[data-seo-counter]').forEach(init);
	});
})();
