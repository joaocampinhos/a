var app = angular.module("spacialAnalysis");

app.directive('draggable', ['$document' , function($document) {
    return {
      restrict: 'A',
      link: function(scope, elm, attrs) {
        var startX, startY, initialMouseX, initialMouseY;
        elm.parent().css({right: '20px'});

        elm.bind('mousedown', function($event) {
          startX = elm.parent().prop('offsetLeft');
          startY = elm.parent().prop('offsetTop');
          initialMouseX = $event.clientX;
          initialMouseY = $event.clientY;
          $document.bind('mousemove', mousemove);
          $document.bind('mouseup', mouseup);
          return false;
        });
 
        function mousemove($event) {
          var dx = $event.clientX - initialMouseX;
          var dy = $event.clientY - initialMouseY;
          elm.parent().css({
            bottom: "",
            right: "",
            top:  startY + dy + 'px',
            left: startX + dx + 'px'
          });
          return false;
        }
 
        function mouseup() {
          $document.unbind('mousemove', mousemove);
          $document.unbind('mouseup', mouseup);
        }
      }
    };
  }]);