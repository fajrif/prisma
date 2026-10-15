// app/assets/javascripts/locations.js
let map;
let markers = [];
let infoWindows = [];
let products = [];
// T15: Google Maps API (±1 MB skrip + 72 marker) baru dimuat saat peta mendekati layar, atau saat
// pengunjung mengklik item daftar lebih dulu. Peta berada di bawah lipatan, jadi skrip Maps tidak lagi
// ikut membebani pemuatan awal (LCP/TBT). URL API ada di data-maps-src pada #map.
let mapsRequested = false;
let pendingProductId = null;

function loadMapsApi() {
  const el = document.getElementById('map');
  if (mapsRequested || !el || !el.dataset.mapsSrc) return;
  mapsRequested = true;
  const script = document.createElement('script');
  script.src = el.dataset.mapsSrc; // memanggil callback initMap setelah siap
  script.async = true;
  document.head.appendChild(script);
}

async function initMap() {
  const mapData = document.getElementById('map-data');
  if (!mapData) return;

  products = JSON.parse(mapData.dataset.products);
  const centerLat = parseFloat(mapData.dataset.centerLat);
  const centerLng = parseFloat(mapData.dataset.centerLng);

  // Import the AdvancedMarkerElement library
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement, PinElement } = await google.maps.importLibrary("marker");

  // Initialize map
  map = new Map(document.getElementById('map'), {
    center: { lat: centerLat, lng: centerLng },
    zoom: 15,
    mapId: '3a496c8aa14f954cb04a4a27', // Required for AdvancedMarkerElement
    gestureHandling: 'greedy', // Allow smooth dragging without ctrl/cmd key
    disableDefaultUI: false,
    zoomControl: true,
    mapTypeControl: false,
    scaleControl: true,
    streetViewControl: false,
    rotateControl: false,
    fullscreenControl: true
  });

  // Create markers for our products
  createMarkers(AdvancedMarkerElement, PinElement);

  // List item click events
  bindProductItemClicks();

  // Close all info windows when map is dragged
  map.addListener('drag', function () {
    closeAllInfoWindows();
  });

  // Item yang diklik sebelum peta siap: buka sekarang.
  if (pendingProductId !== null) {
    $(`.product-item[data-product-id="${pendingProductId}"]`).trigger('click');
    pendingProductId = null;
  }
}

function createMarkers(AdvancedMarkerElement, PinElement) {
  // Clear existing markers
  markers.forEach(marker => {
    marker.map = null;
  });
  markers = [];
  infoWindows = [];

  // Create markers and info windows for our products
  products.forEach(function (product, index) {
    // Create a custom pin for our products
    const pinElement = new PinElement({
      background: "#dc3545",
      borderColor: "#721c24",
      glyphColor: "#721c24"
    });

    const marker = new AdvancedMarkerElement({
      map: map,
      position: { lat: parseFloat(product.latitude), lng: parseFloat(product.longitude) },
      title: product.name,
      content: pinElement.element
    });

    // Store productId on marker - this identifies it as our custom marker
    marker.productId = product.id;

    const infoWindowContent = `
      <div class="custom-info-window" style="max-width: 200px;">
        ${product.image_url_thumb ? `<img src="${product.image_url_thumb}" alt="${product.name}" class="border w-100" style="max-width: 200px; margin-bottom: 10px;">` : ''}
        <h6 class="fw-semibold mb-2 text-wrap"><a class="text-white-2 text-hover" href="${product.product_url_path}">${product.name}</a></h6>
        <p style="font-size: 0.9em;">${product.est_impression || ''}</p>
      </div>
    `;

    const infoWindow = new google.maps.InfoWindow({
      content: infoWindowContent,
      disableAutoPan: true // Prevent auto-panning when InfoWindow opens
    });

    markers.push(marker);
    infoWindows.push(infoWindow);

    // Marker click event - only our custom markers have productId
    marker.addListener('click', function () {
      // Only show custom InfoWindow for our product markers (those with productId)
      if (marker.productId) {
        closeAllInfoWindows();
        infoWindow.open(map, marker);
        highlightProduct(product.id);
      }
    });
  });
}

function bindProductItemClicks() {
  $('.product-item').off('click').on('click', function (e) {
    // Klik pada nama titik (link) membuka halaman billboard, bukan menggeser peta.
    if ($(e.target).closest('a').length) return;
    const productId = $(this).data('product-id');
    const index = products.findIndex(p => p.id === productId);

    if (index !== -1) {
      // Close all existing info windows
      closeAllInfoWindows();

      // Pan to the marker location when clicking sidebar item
      map.panTo(markers[index].position);

      // Wait for pan animation to complete before opening InfoWindow
      // panTo animation takes ~300ms, so we wait 400ms to be safe
      setTimeout(function () {
        infoWindows[index].open(map, markers[index]);
      }, 1000);

      // Highlight the selected product in sidebar
      highlightProduct(productId);
    }
  });
}

function closeAllInfoWindows() {
  infoWindows.forEach(function (iw) {
    iw.close();
  });
}

function highlightProduct(productId) {
  $('.product-item').removeClass('selected');
  $(`.product-item[data-product-id="${productId}"]`).addClass('selected');

  // Scroll to the selected item
  const selectedItem = $(`.product-item[data-product-id="${productId}"]`);
  if (selectedItem.length) {
    $('#product-list').animate({
      scrollTop: selectedItem.position().top + $('#product-list').scrollTop() - 20
    }, 300);
  }
}

// Reinitialize map after AJAX update
async function reinitializeMap() {
  const mapData = document.getElementById('map-data');
  if (!mapData) return;

  products = JSON.parse(mapData.dataset.products);
  // Peta belum dimuat: initMap nanti membaca #map-data yang baru ini.
  if (!map) return;

  if (products.length > 0) {
    // Import marker library
    const { AdvancedMarkerElement, PinElement } = await google.maps.importLibrary("marker");

    // Recreate markers
    closeAllInfoWindows();
    createMarkers(AdvancedMarkerElement, PinElement);

    // Rebind click events for new product items
    bindProductItemClicks();

    // Setelah filter berubah, arahkan peta ke item pertama di daftar baru (urutan daftar = urutan
    // `products`) dan kembalikan daftar ke atas agar item itu terlihat.
    map.panTo({ lat: parseFloat(products[0].latitude), lng: parseFloat(products[0].longitude) });
    $('#product-list').scrollTop(0);
  } else {
    // Clear markers if no products
    markers.forEach(marker => {
      marker.map = null;
    });
    markers = [];
    infoWindows = [];
  }
}

// Billboard type filter change handler
$(document).ready(function () {
  const mapEl = document.getElementById('map');
  if (mapEl) {
    if ('IntersectionObserver' in window) {
      const observer = new IntersectionObserver(function (entries) {
        if (entries.some(e => e.isIntersecting)) {
          observer.disconnect();
          loadMapsApi();
        }
      }); // tanpa rootMargin: di desktop peta hanya ±130px di bawah layar awal
      observer.observe(mapEl);
    } else {
      loadMapsApi();
    }
  }

  // Klik item daftar sebelum peta dimuat: muat peta, lalu buka item itu di initMap.
  $(document).on('click', '.product-item', function (e) {
    if (map || $(e.target).closest('a').length) return;
    pendingProductId = $(this).data('product-id');
    loadMapsApi();
  });

  // Location select change handler
  $('#location-select').on('change', function () {
    const slug = $(this).val();
    window.location.href = `/locations/${slug}`;
  });

  // Billboard type filter change handler
  $('#billboard-type-filter').on('change', function () {
    const billboardType = $(this).val();
    // Path dirender server-side sehingga sudah membawa prefix bahasa (/id, /cn).
    // Sebelumnya path disusun di sini sebagai `/locations/${slug}`, yang membuang
    // prefix tersebut dan melempar pengunjung /id dan /cn kembali ke versi Inggris.
    const locationPath = $(this).data('location-path') || `/locations/${$(this).data('location-id')}`;

    // Update browser URL without reloading
    const url = billboardType
      ? `${locationPath}?billboard_type=${encodeURIComponent(billboardType)}`
      : locationPath;
    window.history.pushState({}, '', url);

    // Make AJAX request to update content
    $.ajax({
      url: locationPath,
      type: 'GET',
      dataType: 'script',
      data: { billboard_type: billboardType }
    });
  });

  // Handle browser back/forward navigation
  window.addEventListener('popstate', function () {
    // Reload the page when user navigates with browser buttons
    // This ensures the filter state matches the URL
    location.reload();
  });
});

// Make functions available globally
window.initMap = initMap;
window.reinitializeMap = reinitializeMap;

