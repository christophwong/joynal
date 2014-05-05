//refactor the clickTab function!!!!!!!!!!!!!!!!!!!
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


showPage = function() {
    console.log("THIS:");
    
    var entry_id = $(this).attr('href');
    $('body').on('ajax:success', '.user-entry', function(e, data, status, xhr) {
      console.log("rabbit");
    $('div.partial').html(data);
  });
};

dateSwitch = function() {  
  console.log("hello")
  $('body').on('ajax:success', '#month a', function(e, data, status, xhr) {
    $('div.partial').html(data);  // why does this send so many requests per click???
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

$(document).ready(function() {
  clickTab();
  entryListener();
  dateSwitch();
  showPage();
});


$(document).on('page:load', function() {
  clickTab();
  entryListener();
  dateSwitch();
  showPage();
});
