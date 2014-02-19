var app = angular.module("spacialAnalysis");

app.directive('dimensions', function($window, ContextService) {
  return function (scope, element) {
    angular.element($window).bind('resize', function () {
      var map = document.getElementById("map_canvas");
      ContextService.map.view.canvasDimensions.width  = map.clientWidth;
      ContextService.map.view.canvasDimensions.height = map.clientHeight;
      console.log(ContextService);
    });
  };
});