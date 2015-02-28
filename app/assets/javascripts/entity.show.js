$(document).ready(function() {

  // Image Area Highlighter

  $('#picture').mapster({
      isSelectable: false,
      stroke: true,
      stroke: true,
      strokeWidth: 2,
      strokeColor: 'ffffff',
      strokeOpacity: 0.6,
      fillOpacity: 0
  });

  $("area").mapster('set', true);

  // Form Manager

  $(".toggle").click(function() {
    panel = $(this).parent().parent().next(".panel");
    if( ! panel.is(":visible") ) {
      $(".panel").slideUp();
      panel.slideDown();
    } else {
      $(".panel").slideUp();
    }
  });

  // Obtain Family Tree Names

  var people = []

  $('.person_data').each(function() {
    people.push( $(this).text() )
  });

  $('.person_name_input').autocomplete({
    source: people,
    minLength: 0
  });

  $('.person_name_input').click(function() {
    $(this).autocomplete( "search", $(this).val() )
  });

});