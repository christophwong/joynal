clickTab = function () {
  $('.tab-head').on('click', function(e) {
    e.preventDefault();
    var partial = $(this).attr('href');
    $("#journal_entry_content").focus();
    $.ajax({
      url: "/journal_entries/"+partial,
      type: "GET",
      datatype: 'html',
      complete: function(response) {
        $('div.partial').html(response.responseText);
      }
    });
  });
};

entryListener = function(){
  $('body').on('ajax:success', '#new_journal_entry', function(e, data, status, xhr) {
    $('div.partial').html(data);
    getQuote();
  });
};

getQuote = function(){
  setTimeout(function(){
    $.get("/journal_entries/get_quote")
      .success(function( data ){
        $('div.quote-box').html("<p class='body'>" + data.body + "</p> <p class='author'>" + data.author + "</p>");
        dropQuote();
      });
  },5000);
};

dropQuote = function(){
  $('div.quote-box').slideDown(800, function(){
    setTimeout(function(){
      $('div.quote-box').slideUp(800);
    },8000);
  });
};

find = function() {
  // Check to see if the browser supports the GeoLocation API.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position){
      var lat = position.coords.latitude;
      var lon = position.coords.longitude;
      console.log(lat);
      console.log(lon);
    });
  }else{
    // Print out a message to the user.
    document.write('Your browser does not support GeoLocation');
  }
};
// completely refreshes a page
$(document).ready(function() {
  clickTab();
  entryListener();
  find();
});


$(document).on('page:update', function() {
  clickTab();
  entryListener();
});