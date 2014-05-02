clickTab = function () {
  $('.tab-head').on('click', function(e) {
    e.preventDefault();
    console.log($(this).attr('href'))
    $('.tab').hide();
    $('li').removeClass('active');
    $(this).parent().addClass('active');
    $($(this).attr('href')).show();
  });
}

// completely refreshes a page
$(document).ready(function() {
  clickTab();
});

// go to a page using turbolinks (i.e. clicks)
$(document).on('page:load', function() {
  clickTab();
});
