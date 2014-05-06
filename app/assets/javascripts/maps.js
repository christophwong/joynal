function initialize() {

  var myLatLng = new google.maps.LatLng(4678342.464270972,-87.7321554);

  var mapOptions = {
    zoom: 8,
    center: myLatLng
  };
  var map = new google.maps.Map($("#map-canvas")[0],
      mapOptions);

  var marker = new google.maps.Marker({
      position: myLatLng,
      map: map,
      title: 'Hello World!'
  });

}

function showMap() {
  $('.show-map').on('click', function(e) {
    e.preventDefault();
    $.ajax({
      url: '/journal_entries/map',
      type: 'GET',
      complete: function(response) {
        $('div.partial').html(response.responseText);
        initialize();
      }
    })
  })
}

$(document).ready(function() {
  showMap();
})

$(document).on('page:load', function() {
  showMap();
})
