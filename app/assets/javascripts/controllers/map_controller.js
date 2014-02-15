var app = angular.module("spacialAnalysis");

app.controller("mapController", function sidebarController($scope, ContextService, Map) {
  
  var mapInstance = new Map('map_canvas', 900, 600);

  ContextService.mapObj = mapInstance;

  $scope.redraw = function(){
    mapInstance.map.invalidateSize();
  };

});