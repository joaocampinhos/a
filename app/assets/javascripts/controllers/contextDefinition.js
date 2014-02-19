var app = angular.module("spacialAnalysis");

app.controller("contextDefinition", function($scope, ContextService) {

  $scope.val = function() {
    //Actualizar contexto com este valor
    console.log($scope.pixel);
  };

});