function initialize(json_array) {

  var myLatLng = new google.maps.LatLng(43.397, -87.644);

  var mapOptions = {
    zoom: 2,
    center: myLatLng
  };

  var map = new google.maps.Map($("#map-canvas")[0],
      mapOptions);

  for(var i=0;i<json_array.length;i++) {
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(json_array[i].location[0], json_array[i].location[1]),
      map: map,
      animation: google.maps.Animation.DROP,
      title: json_array[i].date
    });
    marker.set("type", "point");
    marker.set("class", "markers");
  }

  // marker.on('mouseover', function(e) {
  //   alert("FUCKYOU!!!!")
  // })

}

function getCoords() {
  $.ajax({
    url: '/journal_entries/get_coords',
    type: 'GET',
    dataType: 'json',
    complete: function(response) {
      initialize($.parseJSON(response.responseText));
    }
  })
}

function showMap() {
  $('.show-map').on('click', function(e) {
    e.preventDefault();
    $.ajax({
      url: '/journal_entries/map',
      type: 'GET',
      complete: function(response) {
        $('div.partial').html(response.responseText);
        getCoords();

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
