// Konfigurasi PurgeCSS untuk CSS tema publik (T15). Dijalankan lewat `bin/rails css:purge`, bukan langsung:
// task itu lebih dulu merender semua halaman sitemap ke tmp/purgecss/html dan menulis kelas dari CMS ke
// tmp/purgecss/db.txt. Hasil: vendor/assets/stylesheets/*.purged.css (dipakai application.css).
//
// Prinsip: lebih baik menyisakan rule yang tidak terpakai daripada membuang yang terpakai. Karena itu
// selain HTML hasil render, semua view publik (termasuk template snippet yang belum dipakai halaman mana pun),
// helper, dan JS bundel publik ikut dipindai: kelas yang ditambahkan JS saat interaksi (menu mobile,
// header sticky, dropdown, popup, swiper) muncul sebagai string di JS dan tetap dipertahankan.
const fs = require('fs');
const path = require('path');

function files(dir, pattern, exclude) {
  if (!fs.existsSync(dir)) return [];
  return fs.readdirSync(dir, { recursive: true })
    .map(f => path.join(dir, f))
    .filter(f => pattern.test(f) && !(exclude && exclude.test(f)) && fs.statSync(f).isFile());
}

const ADMIN = /(^|\/)(admins|admin|devise|layouts\/(admin|login))(\/|\.|$)/;
const JS_BUNDLE = ['bootsnav.js', 'jquery.nav.js', 'hamburger-menu.js', 'theme-vendors.min.js', 'main.js', 'a11y.js']
  .map(f => path.join('vendor/assets/javascripts', f));

module.exports = {
  css: ['bootsnav.css', 'theme-vendors.min.css', 'style.css', 'custom.css', 'responsive.css']
    .map(f => path.join('vendor/assets/stylesheets', f)),
  content: [
    ...files('tmp/purgecss/html', /\.html$/),
    'tmp/purgecss/db.txt',
    ...files('app/views', /\.erb$/, ADMIN),
    ...files('app/helpers', /\.rb$/, /admin/),
    ...files('app/assets/javascripts', /\.js$/, /admin|app\.js$/),
    ...JS_BUNDLE,
  ],
  safelist: {
    // Kelas yang dibentuk dinamis (Swiper/Magnific menyusun nama kelas dari potongan string) atau dipasang
    // pustaka di luar file yang dipindai. animate__* sengaja tidak di sini: kelas animasi ditulis utuh di view,
    // dan mempertahankan semuanya berarti membawa seluruh keyframes animate.css (±28 KB).
    standard: [
      /^swiper/, /^mfp-/, /^wow/, /^gm-/, /^grecaptcha/, /^trix-/, /^attachment/, /^ui-/,
      // Kelas spasi yang biasa diisi admin di field css_class Section/Snippet (CMS).
      /-section$/, /no-padding/, /^[mp][tbsexy]?-[0-5]$/,
    ],
  },
  keyframes: true, // buang @keyframes yang tidak dirujuk rule yang tersisa
  fontFace: true, // buang @font-face yang tidak dirujuk
};
