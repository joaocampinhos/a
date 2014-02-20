var app = angular.module('spacialAnalysis');

app.factory('ContextService', function() {
  return {
    pixelResolution: 0,
    selectedDataSet: null,
    mapObj: null,
    map: {
      zoom: 13,
      center: {}, // Preciso?
      bounds: {
        bottomLeft: {},
        topRight: {}
      },
      view: {
        origin: {}, // Preciso?
        canvasDimensions: {
          width: 0,
          height: 0
        }
      }
    }
  };
});
