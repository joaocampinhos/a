var app = angular.module("spacialAnalysis");

app.controller("sidebarController", function sidebarController($scope, ContextService, DatasetService, $location, datasetModal){

  loadDatasets();

  $scope.importData = datasetModal.activate;

  $scope.map = function(id) {
    ContextService.selectedDataSet = id;
    DatasetService.get(id).then(function(dataset) {
      ContextService.mapObj.drawDotLayer(dataset, ContextService.pixelResolution);
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

