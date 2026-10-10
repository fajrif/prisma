// Konfigurasi TinyMCE untuk blok FAQ & tabel (T8). TinyMCE dimuat dari jsDelivr (versi dipatok)
// hanya di form yang memerlukannya; lihat partial admins/shared/_tinymce.
//
// Markup dibatasi di editor (valid_elements) DAN disanitasi lagi saat render
// (ContentBlocksHelper#rich_block_html), karena isi disimpan apa adanya di database.
(function () {
	var TEXT_ELEMENTS = 'p,br,strong/b,em/i,u,a[href|target|title|rel],ul,ol,li';
	var TABLE_ELEMENTS = 'table,caption,thead,tbody,tfoot,tr,th[scope|colspan|rowspan],td[colspan|rowspan]';

	var base = {
		license_key: 'gpl',
		promotion: false,
		branding: false,
		menubar: false,
		statusbar: false,
		convert_urls: false,
		relative_urls: false,
		entity_encoding: 'raw',
		invalid_styles: '*',
		object_resizing: false,
		min_height: 260
	};

	var presets = {
		// Tabel: header baris sebagai <thead><th>, tanpa gaya/ukuran inline dari editor.
		table: {
			plugins: 'table lists link autoresize',
			toolbar: 'undo redo | bold italic | bullist numlist | link | table tableinsertrowafter tableinsertcolafter tabledeleterow tabledeletecol | tablerowheader tablecellprops | removeformat',
			valid_elements: TEXT_ELEMENTS + ',' + TABLE_ELEMENTS,
			table_header_type: 'sectionCells',
			table_use_colgroups: false,
			table_resize_bars: false,
			table_appearance_options: false,
			table_advtab: false,
			table_cell_advtab: false,
			table_row_advtab: false,
			table_style_by_css: false,
			table_default_attributes: {},
			table_default_styles: {},
			min_height: 360
		},
		// Jawaban FAQ: teks sederhana, boleh berisi tabel (aturan tabel sama dengan preset table).
		faq_answer: {
			plugins: 'table lists link autoresize',
			toolbar: 'undo redo | bold italic | bullist numlist | link | table tablerowheader | removeformat',
			valid_elements: TEXT_ELEMENTS + ',' + TABLE_ELEMENTS,
			table_header_type: 'sectionCells',
			table_use_colgroups: false,
			table_resize_bars: false,
			table_appearance_options: false,
			table_advtab: false,
			table_cell_advtab: false,
			table_row_advtab: false,
			table_style_by_css: false,
			table_default_attributes: {},
			table_default_styles: {}
		}
	};

	window.PrismaTinymce = {
		init: function (selector, preset) {
			if (!window.tinymce) return;
			window.tinymce.init(Object.assign({ selector: selector }, base, presets[preset] || {}));
		},
		remove: function (selector) {
			if (window.tinymce) window.tinymce.remove(selector);
		}
	};
})();
