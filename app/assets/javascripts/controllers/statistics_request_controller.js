var app = angular.module("spacialAnalysis");

app.controller("statisticsRequestController", function($scope, $rootScope, StatisticsService, ContextService) {

  // GET todos os tipos de gráficos que podemos pedir
  loadChartTypes();

  $scope.compute = function() {
    console.log(createArgs());
    //Normalizar objecto a enviar ao servidor
    var data = createArgs();
    //Enviar o pedido ao servidor
    StatisticsService.get(data).then(function(res) {
      //Fazer broadcast da resposta para o controlador que vai desenhar o gráfico
      //...  
      console.log(res);
      $rootScope.$broadcast('statisticLoaded', res)
    });
  };

  function loadChartTypes() {
    StatisticsService.getAll().then(function(res) {
      $scope.charts = res;
    });
  }

  function createArgs() {
    return {
      map: {
        canvas: {
          width: ContextService.map.view.canvasDimensions.width,
          height: ContextService.map.view.canvasDimensions.height
        },
        bounds: {
          bl: {
            latitude: ContextService.map.bounds.bottomLeft.latitude,
            longitude: ContextService.map.bounds.bottomLeft.longitude
          },
          tr: {
            latitude: ContextService.map.bounds.topRight.latitude,
            longitude: ContextService.map.bounds.topRight.longitude
          }
        }
      },
      visualization: {
        name: ContextService.visualization,
        params: {
          size: ContextService.pixelResolution
        }
      },
      dataset: ContextService.selectedDataSet,
      statistic: $scope.statisticId
    };
  }

});