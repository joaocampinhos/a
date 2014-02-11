var app = angular.module("spacialAnalysis");

app.controller("mapController", function sidebarController($scope, Map) {
  
  var mapInstance = new Map('map_canvas', 900, 600);

  $scope.redraw = function(){
    mapInstance.map.invalidateSize();
  };

});