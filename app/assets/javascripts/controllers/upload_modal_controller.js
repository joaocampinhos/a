var app = angular.module('spacialAnalysis');

app.controller('uploadModalController', function($scope, $rootScope, datasetModal, $upload){

  $scope.closeModal = datasetModal.deactivate;

  $scope.uploadStart = function(){
    //Error/required verification
    if (!$scope.datasetname){ $scope.modalError = "Please enter a name." ; return null; }
    if (!$scope.datasetid)  { $scope.modalError = "Please enter an id."  ; return null; }
    if (!$scope.files)      { $scope.modalError = "Please select a file."; return null; }

    datasetModal.deactivate();
    var metas = document.getElementsByTagName('meta');
    var token;
    for (i=0; i<metas.length; i++) {
      if (metas[i].getAttribute("name") == "csrf-token") {
        token = metas[i].getAttribute("content");
      }
    }

    var file = $scope.files[0];
    var newDataset = {name: $scope.datasetname, id: $scope.datasetid};
    var upload = $upload.upload({
      url: 'datasets',
      headers: {
        'X-CSRF-Token': token
      },
      data: newDataset,
      file: file
    });
    upload.success(function(data, status, headers, config){
      console.log('Upload successed');
      $rootScope.$broadcast('newDataset');
    });
  };

  $scope.onFileSelect = function($files) {
    $scope.files = $files;
  };

});