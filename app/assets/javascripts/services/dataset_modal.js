var app = angular.module('spacialAnalysis');

app.factory('datasetModal', function (btfModal) {
  return btfModal({
    controller: 'uploadModalController',
    templateUrl: 'datasetModal.html'
  });
});