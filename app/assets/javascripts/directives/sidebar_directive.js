var app = angular.module("spacialAnalysis");

app.directive("sidebar", function($window) {
  return function (scope, element) {
    var w = angular.element($window);
    var a = document.querySelectorAll('.side-up');
    var b = document.querySelectorAll('.side-down')[0].offsetHeight;
    Array.prototype.forEach.call(a, function(el, index, nodeList) {
      b+=el.offsetHeight;
    });
    var tots = $window.innerHeight - b;
    element.css("height",tots+"px");
    w.bind("resize", function () {
      var tots = $window.innerHeight - b;
      element.css("height",tots+"px");
    });
  };
});