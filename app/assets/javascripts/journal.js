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
  });

  // $('#new_journal_entry').on('click', '.journal-submit', function(e) {
  //   console.log("HELLO!!!");
  //   e.preventDefault();
  //   $.ajax({
  //     url: '/journal_entries',
  //     type: 'POST',
  //     data: {
  //       content: $('#journal_entry_content').val(),
  //       emotion_rating: $('#journal_entry_emotion_rating').val(),
  //       tags: $('#journal_entry_tags').val()
  //     },
  //     success: function(response) {
  //       console.log(response);
  //     }
  //   });
  // });

};

// entryListener = function(){
//   $('#new_journal_entry').on("click", function(){
//     console.log("click");
//   });
// }
// completely refreshes a page
$(document).ready(function() {
  clickTab();
  entryListener();
});

// go to a page using turbolinks (i.e. clicks)
// $(document).on('page:load', function() {
//   clickTab();
//   entryListener();
// });

$(document).on('page:update', function() {
  clickTab();
  entryListener();
});