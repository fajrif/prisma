// app/assets/javascripts/locations.js
let map;
let markers = [];
let infoWindows = [];
let products = [];

async function initMap() {
  const mapData = document.getElementById('map-data');
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

  // Create markers and info windows
  products.forEach(function(product, index) {
    // Create a custom pin
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

    // Store productId on marker
    marker.productId = product.id;

    const infoWindowContent = `
      <div class="info-window-content">
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

    // Marker click event
    marker.addListener('click', function() {
      closeAllInfoWindows();
      infoWindow.open(map, marker);
      highlightProduct(product.id);
    });
  });

  // List item click events
  $('.product-item').on('click', function() {
    const productId = $(this).data('product-id');
    const index = products.findIndex(p => p.id === productId);

    if (index !== -1) {
      closeAllInfoWindows();
      infoWindows[index].open({
        anchor: markers[index],
        map: map
      });
      map.panTo(markers[index].position);
      map.setZoom(15);
      highlightProduct(productId);
    }
  });
}

function closeAllInfoWindows() {
  infoWindows.forEach(function(iw) {
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

// Location select change handler
$(document).ready(function() {
  $('#location-select').on('change', function() {
    const slug = $(this).val();
    window.location.href = `/locations/${slug}`;
  });
});

// Make initMap available globally for Google Maps callback
window.initMap = initMap;
