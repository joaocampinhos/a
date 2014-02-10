var app = angular.module("spacialAnalysis");

app.directive('fullsize', function($window) {
  return function (scope, element) {
    var w = angular.element($window);
    var tots = $window.innerHeight;
    element.css("height",tots+"px");
    w.bind('resize', function () {
      var tots = $window.innerHeight;
      element.css("height",tots+"px");
    });
    scope.redraw();
  };
});