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


function getGeoLocation() {
  navigator.geolocation.getCurrentPosition(setGeoCookie);
}

function setGeoCookie(position) {
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  document.cookie = "lat_lng=" + escape(cookie_val);
}

// completely refreshes a page
$(document).ready(function() {
  clickTab();
  entryListener();
  getGeoLocation();
});


$(document).on('page:update', function() {
  clickTab();
  entryListener();
  getGeoLocation();
});