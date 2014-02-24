var app = angular.module("spacialAnalysis");

app.directive('expand', function($window) {
  return function (scope, element) {
    var el = element[0];
    var toggle = scope.showPnl;

    //Como a div tem um height dinamico, temos de ajustar on resize da window
    angular.element($window).bind('resize', function () {
      if (toggle)
        element.parent().css("margin-top",-1*element.parent()[0].offsetHeight + "px");
    });

    //bind on click para mudar essa margem
    element.bind('click',function(){
      element.parent().css("margin-top",-1*element.parent()[0].offsetHeight + "px");
    });

  };
});