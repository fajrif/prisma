// Form Schema Manager: menampilkan field sesuai scope, mengisi template JSON,
// dan memuat ulang daftar record ketika tipe model diganti.
jQuery(document).ready(function ($) {
  var $scope = $('#schema_markup_scope_type');
  if ($scope.length === 0) { return; }

  function toggleScopeFields() {
    var scope = $scope.val();

    $('.schema_markup_schemable_type, .schema_markup_schemable_id').toggle(scope === 'record');
    $('.schema_markup_path_pattern').toggle(scope === 'path');
  }

  $scope.on('change', toggleScopeFields);
  toggleScopeFields();

  // Ganti tipe model -> muat ulang pilihan record
  $('#schema_markup_schemable_type').on('change', function () {
    var selected = $(this).find(':selected').val();
    var url = $(this).attr('data-url').replace('selected', selected);

    $.ajax({ url: url, dataType: 'script' });
    return false;
  });

  // Isi kolom JSON dengan template sesuai schema type
  $('#schema_markup_load_preset').on('click', function () {
    var $type = $('#schema_markup_schema_type');
    var presets = $type.data('presets') || {};
    var template = presets[$type.val()];

    if (!template) {
      alert('Belum ada template untuk tipe ' + $type.val() + '. Silakan isi JSON secara manual.');
      return;
    }

    var $body = $('#schema_markup_body');
    if ($body.val().trim() !== '' && !confirm('Ganti isi JSON yang sekarang dengan template?')) {
      return;
    }

    $body.val(JSON.stringify(template, null, 2));
  });
});
