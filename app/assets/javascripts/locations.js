// app/assets/javascripts/locations.js
let map;
let markers = [];
let infoWindows = [];
let products = [];

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
    mapId: '3a496c8aa14f954cb04a4a27' // Required for AdvancedMarkerElement
  });

  // Create markers for our products
  createMarkers(AdvancedMarkerElement, PinElement);

  // List item click events
  bindProductItemClicks();
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
      glyphColor: "#ffffff"
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
      <div class="custom-info-window">
        ${product.image_url_thumb ? `<img src="${product.image_url_thumb}" alt="${product.name}" class="border w-100" style="max-width: 200px; margin-bottom: 10px;">` : ''}
        <h6 class="fw-semibold mb-2"><a class="text-white-2 text-hover" href="${product.product_url_path}">${product.name}</a></h6>
        <p style="font-size: 0.9em;">${product.est_impression || ''}</p>
      </div>
    `;

    const infoWindow = new google.maps.InfoWindow({
      content: infoWindowContent
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
  $('.product-item').off('click').on('click', function () {
    const productId = $(this).data('product-id');
    const index = products.findIndex(p => p.id === productId);

    if (index !== -1) {
      // Close all existing info windows first
      closeAllInfoWindows();

      // Set zoom level
      map.setZoom(15);

      // Pan to marker position
      map.panTo(markers[index].position);

      // Wait for map to finish panning before opening info window
      google.maps.event.addListenerOnce(map, 'idle', function () {
        // Open info window anchored to the marker after map is idle
        infoWindows[index].open({
          anchor: markers[index],
          map: map
        });
      });

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

  if (products.length > 0) {
    const centerLat = parseFloat(mapData.dataset.centerLat);
    const centerLng = parseFloat(mapData.dataset.centerLng);

    // Update map center
    map.setCenter({ lat: centerLat, lng: centerLng });

    // Import marker library
    const { AdvancedMarkerElement, PinElement } = await google.maps.importLibrary("marker");

    // Recreate markers
    createMarkers(AdvancedMarkerElement, PinElement);

    // Rebind click events for new product items
    bindProductItemClicks();
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
  // Location select change handler
  $('#location-select').on('change', function () {
    const slug = $(this).val();
    window.location.href = `/locations/${slug}`;
  });

  // Billboard type filter change handler
  $('#billboard-type-filter').on('change', function () {
    const billboardType = $(this).val();
    const locationId = $(this).data('location-id');

    $.ajax({
      url: `/locations/${locationId}`,
      type: 'GET',
      dataType: 'script',
      data: { billboard_type: billboardType }
    });
  });
});

// Make functions available globally
window.initMap = initMap;
window.reinitializeMap = reinitializeMap;

