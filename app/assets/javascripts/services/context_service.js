var app = angular.module('spacialAnalysis');

app.factory('ContextService', function() {
  return {
    pixelResolution: 0,
    selectedDataSet: null,
    visualization: "DotLayer",
    mapObj: null,
    map: {
      zoom: 13,
      center: {},
      bounds: {
        bottomLeft: {},
        topRight: {}
      },
      view: {
        origin: {},
        canvasDimensions: {
          width: 0,
          height: 0
        }
      }
    }
  };
});
