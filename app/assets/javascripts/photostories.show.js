$(document).ready(function() {

  var inArea;
  var img = $('#picture');

  var all_opts = {
      stroke: true,
      strokeWidth: 1,
      strokeColor: 'ffffff',
      strokeOpacity: 0.4,
      fillOpacity: 0
  };
  var single_opts = {
      stroke: true,
      strokeWidth: 2,
      strokeColor: 'ffffff',
      strokeOpacity: 0.6
  };
  var initial_opts = {
      isSelectable: false,
      clickNavigate: false,
      onMouseover: function (data) {
          inArea = true;
      },
      onMouseout: function (data) {
          inArea = false;
      }
  };
  var opts = $.extend({}, all_opts, initial_opts, single_opts);

  // Bind to the image 'mouseover' and 'mouseout' events to activate or deactivate ALL the areas. Check whether an area has been activated with "inArea" - IE<9 fires "onmouseover" again for the image when entering an area, so all areas would stay highlighted when entering a specific area in those browsers otherwise. It makes no difference for other browsers.

 img.mapster('unbind')
        .mapster(opts)
        .bind('mouseover', function () {
            if (!inArea) {
                img.mapster('set_options', all_opts);
                $("area").mapster('set', true);
                img.mapster('set_options', single_opts);
            }
        }).bind('mouseout', function () {
            if (!inArea) {
                $("area").mapster('set', false);
            }
        });

});