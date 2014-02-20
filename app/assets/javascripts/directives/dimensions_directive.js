var app = angular.module("spacialAnalysis");

app.directive('dimensions', function($window, ContextService, $rootScope) {
  return function (scope, element) {
    function _update() {
      var map = document.getElementById("map_canvas");
      ContextService.map.view.canvasDimensions.width  = map.clientWidth;
      ContextService.map.view.canvasDimensions.height = map.clientHeight;
      //Actualizar também as bounds
      ContextService.mapObj.updateContext();
    }
    _update();
    angular.element($window).bind('resize', function () {
      _update();
      $rootScope.$apply();
    });
  };
});