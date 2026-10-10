// T10: kontrol non-<button> yang berperan sebagai tombol (ikon pembuka submenu) bisa dioperasikan
// dengan Enter/Spasi; dan aria-expanded submenu mengikuti state Bootstrap dropdown.
(function () {
	document.addEventListener('keydown', function (e) {
		var el = e.target;
		if (!el || el.getAttribute('role') !== 'button' || el.tagName === 'BUTTON' || el.tagName === 'A') return;
		if (e.key === 'Enter' || e.key === ' ') {
			e.preventDefault();
			el.click();
		}
	});

	function sync(e) {
		var toggle = e.target.parentNode && e.target.parentNode.querySelector('[data-bs-toggle="dropdown"][aria-expanded]');
		if (toggle) toggle.setAttribute('aria-expanded', e.type === 'shown.bs.dropdown' ? 'true' : 'false');
	}
	document.addEventListener('shown.bs.dropdown', sync);
	document.addEventListener('hidden.bs.dropdown', sync);
})();
