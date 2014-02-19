var app = angular.module("spacialAnalysis");

app.controller("sidebarController", function sidebarController($scope, ContextService, DatasetService, $location, datasetModal){

  loadDatasets();

  $scope.importData = datasetModal.activate;

  $scope.isActive = function(route) {
    //id tem de ser igual ao id do dataset guardado no context
    //return route === 
  };

  $scope.map = function(id) {
    DatasetService.get(id).then(function(dataset) {
      ContextService.mapObj.drawDotLayer(dataset, 1);
      //TODO: ver este erro do digest
      ContextService.mapObj.fitToBounds();
    });
  };

  $scope.$on('newDataset', loadDatasets);

  function loadDatasets(){
    DatasetService.getAll().then(function(datasets) {
      $scope.datasets = datasets;
    });
  }

});

