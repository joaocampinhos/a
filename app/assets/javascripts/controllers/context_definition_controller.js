var app = angular.module("spacialAnalysis");

app.controller("contextDefinition", function($scope, ContextService, DatasetService) {

  //Problema com o angular e input[type=range].
  //O angular não aceita o default mas nós "impomos" esse default e já funciona
  $scope.pixel=0;

  $scope.visualization = ContextService.visualization;

  $scope.val = function() {
    ContextService.pixelResolution = $scope.pixel;
    //Redesenhar 
    datasetId = ContextService.selectedDataSet;
    DatasetService.get(datasetId).then(function(data){
      ContextService.mapObj.drawDotLayer(data, ContextService.pixelResolution);
      //ContextService.mapObj.fitToBounds();
    });
  };
});