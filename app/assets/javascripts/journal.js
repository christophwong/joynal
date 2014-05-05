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

dateSwitch = function() {

  $('body').on('ajax:success', '#month a', function(e, data, status, xhr) {
    $('div.partial').html(data); // why does this send so many requests per click???
  });
  
};




entryListener = function() {
  $('body').on('ajax:success', '#new_journal_entry', function(e, data, status, xhr) {
    $('div.partial').html(data);
  });
};


$(document).ready(function() {
  clickTab();
  entryListener();
  dateSwitch();
});


$(document).on('page:update', function() {
  clickTab();
  entryListener();
  dateSwitch();
});