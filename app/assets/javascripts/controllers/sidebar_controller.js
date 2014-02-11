var app = angular.module("spacialAnalysis");

app.controller("sidebarController", function sidebarController($scope, $upload, DatasetService, $location, datasetModal){
  
  DatasetService.getAll().then(function(datasets) {
    return $scope.datasets = datasets;
  });

  $scope.importData = function(){
    datasetModal.activate();
  };

  $scope.onFileSelect = function($files) {
    //$files: an array of files selected, each file has name, size, and type.

    var metas = document.getElementsByTagName('meta');
    var token;

    for (i=0; i<metas.length; i++) {
      if (metas[i].getAttribute("name") == "csrf-token") {
        token = metas[i].getAttribute("content");
      }
    }

    for (var i = 0; i < $files.length; i++) {
      var file = $files[i];
      $scope.upload = $upload.upload({
        url: 'datasets', //upload.php script, node.js route, or servlet url
        // method: POST or PUT,
        // headers: {'headerKey': 'headerValue'},
        // withCredential: true, 

        headers: {
          'X-CSRF-Token': token
        },

        data: {name: $scope.datasetname, id: $scope.datasetid},
        file: file,
        // file: $files, //upload multiple files, this feature only works in HTML5 FromData browsers
        /* set file formData name for 'Content-Desposition' header. Default: 'file' */
        //fileFormDataName: myFile, //OR for HTML5 multiple upload only a list: ['name1', 'name2', ...]
        /* customize how data is added to formData. See #40#issuecomment-28612000 for example */
        //formDataAppender: function(formData, key, val){} //#40#issuecomment-28612000
      }).success(function(data, status, headers, config) {
        DatasetService.getAll().then(function(datasets) {
          return $scope.datasets = datasets;
        });
      });
    }
  };

});

