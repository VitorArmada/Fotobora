$(document).ready(function() {

      // Image Area Highlighter

      $('#picture').mapster({
          isSelectable: false,
          stroke: true,
          strokeWidth: 1,
          strokeColor: 'ffffff',
          strokeOpacity: 0.3,
          fillOpacity: 0
      });

      $("area").mapster('set', true);

      // Form Manager

      $(".toggle").click(function() {
        $(".panel").slideUp();
        $(this).next(".panel").slideDown();
      });

    });