var app = angular.module("spacialAnalysis");

app.controller("contextDefinition", function($scope, ContextService) {

  //Problema com o angular e input[type=range].
  //O angular não aceita o default mas nós "impomos" esse default e já funciona
  $scope.pixel=0;

  $scope.val = function() {
    //Actualizar contexto com este valor
    ContextService.pixelResolution = $scope.pixel;
    //Redesenhar 
  };
});