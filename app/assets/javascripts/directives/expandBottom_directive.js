var app = angular.module("spacialAnalysis");

app.directive('expand', function($window) {
  return function (scope, element) {
    var el = element[0];
    var toggle = false;
    var initstate = -1*el.offsetHeight-10 + "px";

    //dizer à div pai que tem de ter uma margem negativa com o tamanho da div que faz toggle
    element.parent().css("margin-top",initstate);
    element.addClass("menu");

    //Como a div tem um height dinamico, temos de ajustar on resize da window
    angular.element($window).bind('resize', function () {
      if (toggle)
        element.parent().css("margin-top",-1*element.parent()[0].offsetHeight + "px");
      });

    //bind on click para mudar essa margem
    element.bind('click',function(){
      angular.element(document.getElementById("bbar__body")).removeClass("hide");
      element.addClass("hide menu");
      element.parent().css("margin-top",-1*element.parent()[0].offsetHeight + "px");
      toggle = !toggle;
    });

    angular.element(document.getElementById("bbarclose")).bind('click', function() {
      element.removeClass("hide");
      element.parent().css("margin-top",initstate);
      angular.element(document.getElementById("bbar__body")).addClass("hide");
      toggle = !toggle;
    });

  };
});