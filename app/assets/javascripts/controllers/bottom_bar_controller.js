var app = angular.module('spacialAnalysis');

app.controller('bottomBarController', function($scope, $rootScope){
  $scope.showPnl = false;
  $scope.showBtn = false;
  $scope.$on('selected', function() {
    $scope.showPnl = false;
    $scope.showBtn = true;
  });

  $scope.toggle = function() {
    $scope.showPnl = !$scope.showPnl;
    $scope.showBtn = !$scope.showBtn;
  };
});