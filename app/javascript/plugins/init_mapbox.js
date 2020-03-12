import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const mapElement = document.getElementById('mapbox');
const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'mapbox',
    style: 'mapbox://styles/thomasvanholder/ck7mcuz2h08jl1ilxkrfgjhen'

  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    const element = document.createElement('div');
    const compType = document.getElementById('company_type')
    element.className = 'marker';
    // if (compType == 'Bar') {
      element.style.backgroundImage = `url('${marker.image_url}')`;
    //   element.style.backgroundImage = `url('bar.png')`;
    // } else if (compType == 'Cafe') {
    //   element.style.backgroundImage = `url('cafe.png')`;
    // } else {
    //   element.style.backgroundImage = `url('restaurant.png')`;
    // }
    element.style.backgroundSize = 'contain';
    element.style.width = '50px';
    element.style.height = '50px';

    new mapboxgl.Marker(element)
    .setLngLat([ marker.lng, marker.lat ])
    .setPopup(popup)
    .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 10, maxZoom: 12 });
};

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };

