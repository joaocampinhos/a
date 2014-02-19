var app = angular.module("spacialAnalysis");

app.controller("sidebarController", function sidebarController($scope, ContextService, DatasetService, $location, datasetModal){

  loadDatasets();

  $scope.importData = datasetModal.activate;

  $scope.isActive = function(route) {
    return route === $location.path();
  };

  $scope.map = function(id) {
    DatasetService.get(id).then(function(dataset) {
      console.log(dataset);
      ContextService.mapObj.drawDotLayer(dataset, 1);
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

