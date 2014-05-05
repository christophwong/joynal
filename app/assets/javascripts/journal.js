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
        console.log(data);
        $('div.quote-box').html("<p>" + data.body + "</p> <p>" + data.author + "</p>");
       
      });
  },30000);
};





// completely refreshes a page
$(document).ready(function() {
  clickTab();
  entryListener();
});


$(document).on('page:update', function() {
  clickTab();
  entryListener();
});