var app = angular.module("spacialAnalysis");

app.directive('expand', function() {
  return function (scope, element) {
    var el = element[0];
    var toggle = false;
    var initstate = -1*el.offsetHeight-10 + "px";

    //dizer à div pai que tem de ter uma margem negativa com o tamanho da div que faz toggle
    element.parent().css("margin-top",initstate);
    element.addClass("menu");

    //bind on click para mudar essa margem
    element.bind('click',function(){
      element.toggleClass("menu");
      if (toggle){
        element.parent().css("margin-top",initstate);
      }
      else{
        element.parent().css("margin-top",-1*element.parent()[0].offsetHeight + "px");
      }
      toggle = !toggle;
    });
  };
});