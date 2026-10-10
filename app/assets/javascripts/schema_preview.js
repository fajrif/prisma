// Pratinjau schema JSON-LD di tab "SEO Details" (admins/shared/_schema_preview).
// Mengambil HTML halaman publik (same-origin), membaca semua <script type="application/ld+json">,
// lalu menampilkannya: sama persis dengan yang dilihat mesin pencari. Dimuat saat tab dibuka.
(function () {
	function init(card) {
		var paths = JSON.parse(card.dataset.paths);
		var siteUrl = card.dataset.siteUrl;
		var statusEl = card.querySelector('[data-schema-status]');
		var typesEl = card.querySelector('[data-schema-types]');
		var jsonEl = card.querySelector('[data-schema-json]');
		var rich = card.querySelector('[data-schema-rich-results]');
		var current = card.dataset.defaultLocale;
		var loaded = {};

		function setStatus(text, cls) {
			statusEl.className = 'small mb-2 ' + (cls || 'text-muted');
			statusEl.textContent = text;
		}

		function nodes(blocks) {
			var out = [];
			blocks.forEach(function (b) {
				(b['@graph'] || [b]).forEach(function (n) { out.push(n); });
			});
			return out;
		}

		function show(locale, blocks) {
			var list = nodes(blocks);
			typesEl.innerHTML = '';
			list.forEach(function (n) {
				var types = [].concat(n['@type'] || '?');
				types.forEach(function (t) {
					var b = document.createElement('span');
					b.className = 'badge me-1 ' + (t === 'FAQPage' ? 'bg-success' : 'bg-light text-body border');
					b.textContent = t;
					typesEl.appendChild(b);
				});
			});
			jsonEl.textContent = JSON.stringify(blocks.length === 1 ? blocks[0] : blocks, null, 2);
			setStatus(blocks.length + ' blok JSON-LD, ' + list.length + ' node (' + locale.toUpperCase() + '). Isi diambil dari halaman publik saat ini.');
		}

		function load(locale, force) {
			current = locale;
			card.querySelectorAll('[data-schema-locale]').forEach(function (btn) {
				btn.classList.toggle('active', btn.dataset.schemaLocale === locale);
			});
			rich.href = 'https://search.google.com/test/rich-results?url=' + encodeURIComponent(siteUrl + paths[locale]);
			if (loaded[locale] && !force) return show(locale, loaded[locale]);

			setStatus('Memuat ' + paths[locale] + ' …');
			typesEl.innerHTML = '';
			jsonEl.textContent = '';
			fetch(paths[locale], { credentials: 'same-origin', headers: { Accept: 'text/html' } }).then(function (res) {
				if (!res.ok) throw new Error(res.status === 404 ? 'Halaman ini belum tampil di situs (draft atau tidak dipublikasikan di bahasa ini).' : 'Gagal memuat halaman publik (HTTP ' + res.status + ').');
				return res.text();
			}).then(function (html) {
				var doc = new DOMParser().parseFromString(html, 'text/html');
				var blocks = [];
				doc.querySelectorAll('script[type="application/ld+json"]').forEach(function (s) {
					try { blocks.push(JSON.parse(s.textContent)); } catch (e) { blocks.push({ error: 'JSON tidak valid', raw: s.textContent.slice(0, 300) }); }
				});
				loaded[locale] = blocks;
				if (current !== locale) return;
				if (!blocks.length) return setStatus('Tidak ada schema JSON-LD di halaman ini.', 'text-warning');
				show(locale, blocks);
			}).catch(function (err) {
				if (current === locale) setStatus(err.message, 'text-warning');
			});
		}

		card.querySelectorAll('[data-schema-locale]').forEach(function (btn) {
			btn.addEventListener('click', function () { load(btn.dataset.schemaLocale, false); });
		});
		card.querySelector('[data-schema-copy]').addEventListener('click', function (e) {
			var text = jsonEl.textContent;
			if (!text || !navigator.clipboard) return;
			navigator.clipboard.writeText(text).then(function () {
				var btn = e.currentTarget, old = btn.textContent;
				btn.textContent = 'Tersalin';
				setTimeout(function () { btn.textContent = old; }, 1500);
			});
		});

		// Muat saat tab SEO Details dibuka (atau langsung bila tab itu yang aktif).
		var started = false;
		function start() { if (!started) { started = true; load(current, false); } }
		var tabLink = document.querySelector('.nav-tabs a[href="' + card.dataset.seoTab + '"]');
		if (tabLink) tabLink.addEventListener('shown.bs.tab', start);
		var pane = card.closest('.tab-pane');
		if (!pane || pane.classList.contains('active')) start();
	}

	document.addEventListener('DOMContentLoaded', function () {
		document.querySelectorAll('[data-schema-preview]').forEach(init);
	});
})();
