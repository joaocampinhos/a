var app = angular.module("spacialAnalysis");

app.directive("selected", function($window) {
  return function (scope, element) {
    element.bind("click", function() {
      angular.element(document.getElementById("bottombar")).removeClass("hide--vis"); //Só mostrar a barra de baixo se houver algum dataset escolhido
      element.parent().children().removeClass("active");
      element.addClass("active");
    });
  };
});