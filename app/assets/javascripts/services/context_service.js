var app = angular.module('spacialAnalysis');

app.factory('ContextService', function() {
  return {
    pixelResolution: 0,
    selectedDataSet: {},
    mapObj: null,
    map: {
      zoom: 0,
      center: {},
      bounds: {
        bottomLeft: {},
        topRight: {}
      },
      view: {
        origin: {},
        canvasDimensions: {
          width: 900,
          height: 600
        }
      }
    }
  };
});
