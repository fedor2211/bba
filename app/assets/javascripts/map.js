document.addEventListener("turbo:load", () => {
  let eventMap = document.querySelector(".event-map")
  if (!eventMap) return

  ymaps.ready(init);
  var myMap;

  function init(){
    address = eventMap.getAttribute('data-address');

    myMap = new ymaps.Map("map", {
      center: [55.76, 37.64],
      zoom: 7
    });

    myGeocoder = ymaps.geocode(address);

    myGeocoder.then(
      function (res) {
        coordinates = res.geoObjects.get(0).geometry.getCoordinates();

        myMap.geoObjects.add(
          new ymaps.Placemark(
            coordinates,
            {iconContent: address},
            {preset: 'islands#blueStretchyIcon'}
          )
        );

        myMap.setCenter(coordinates);
        myMap.setZoom(15);
      }, function (err) {
        alert('Ошибка при определении местоположения');
      }
    );
  }
})
