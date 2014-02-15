var app = angular.module("spacialAnalysis");

app.controller("sidebarController", function sidebarController($scope, $upload, ContextService, DatasetService, $location, datasetModal){

  DatasetService.getAll().then(function(datasets) {
    return $scope.datasets = datasets;
  });

  $scope.importData = datasetModal.activate;
  $scope.closeModal = datasetModal.deactivate;

  $scope.isActive = function(route) {
    return route === $location.path();
  };

  $scope.map = function(id) {
    DatasetService.get(id).then(function(dataset) {
      console.log(dataset);
      ContextService.mapObj.drawDotLayer(dataset, 1);
    });
  };

  $scope.uploadStart = function() {
    datasetModal.deactivate();

    var metas = document.getElementsByTagName('meta');
    var token;

    for (i=0; i<metas.length; i++) {
      if (metas[i].getAttribute("name") == "csrf-token") {
        token = metas[i].getAttribute("content");
      }
    }

    for (var i = 0; i < $scope.files.length; i++) {
      var file = $scope.files[i];

      $scope.upload = $upload.upload({
        url: 'datasets',

        headers: {
          'X-CSRF-Token': token
        },

        data: {name: $scope.datasetname, id: $scope.datasetid},
        file: file,

      }).success(function(data, status, headers, config) {
        DatasetService.getAll().then(function(datasets) {
          return $scope.datasets = datasets;
        });
      });

    }

  };

  $scope.onFileSelect = function($files) {
    $scope.files = $files;
  };

});

