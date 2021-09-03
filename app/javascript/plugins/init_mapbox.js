import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { padding: 50, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {

      const popup = new mapboxgl.Popup().setHTML(marker.info_window);

      new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
    });
    const markers_hotels = JSON.parse(mapElement.dataset.markers_hotels);
    markers_hotels.forEach((marker) => {

      // const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      // .setPopup(popup)
      .addTo(map);
    });
    fitMapToMarkers(map, markers);

    //Try to draw line
    const route = JSON.parse(mapElement.dataset.route)
    // console.log(route)
    const geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };

    map.on('load', function () {
      map.addSource('route', {
        'type': 'geojson',
        'data': {
          'type': 'Feature',
          'properties': {},
          'geometry': {
            'type': 'LineString',
            'coordinates': route
          }
        }
      });


      map.addLayer({
        id: 'route',
        type: 'line',
        source: 'route',
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': '#255853',
          'line-width': 5,
          'line-opacity': 0.8
        }
      });

      // Add a circle to the origne point
      map.addLayer({
        id: 'point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: [
                  -122.431297,
                  37.773972,
                ]
              }
            }]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#3887be'
        }
      });

    });
  }
};

export { initMapbox };
