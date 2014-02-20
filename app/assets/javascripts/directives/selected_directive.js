var app = angular.module("spacialAnalysis");

app.directive("selected", function($window) {
  return function (scope, element) {
    element.bind("click", function() {
      element.parent().children().removeClass("active");
      element.addClass("active");
    });
  };
});