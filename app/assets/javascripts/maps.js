function initialize(json_array) {

  var myLatLng = new google.maps.LatLng(43.397, -87.644);

  var mapOptions = {
    zoom: 2,
    center: myLatLng
  };

  var map = new google.maps.Map($("#map-canvas")[0],
      mapOptions);

  json_array.forEach(function(journalEntry, i) {

    var contentString = "<div><h3>"+journalEntry.date+"</h3><a class='user-entry' data-remote='true' href='/journal_entries/"+journalEntry.id+"'>"+journalEntry.content.substring(0,50)+"...</a></div>";

    var infoWindow = new google.maps.InfoWindow({
      content: contentString
    });

    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(journalEntry.latitude, journalEntry.longitude),
      map: map,
      animation: google.maps.Animation.DROP,
      title: journalEntry.content
    });

    google.maps.event.addListener(marker, 'click', function() {
      infoWindow.open(map, this);
    });
  });

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
