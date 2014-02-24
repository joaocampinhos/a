var app = angular.module("spacialAnalysis");

app.directive('statshow', function($window) {
  return function (scope, element) {
    element.bind('click',function(){
      angular.element(document.getElementById("draggable")).removeClass("hide"); //Só mostrar a div dos gráficos se houver algum dataset escolhido
    });
  };
});