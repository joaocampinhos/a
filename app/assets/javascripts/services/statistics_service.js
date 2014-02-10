var app = angular.module("spacialAnalysis");

app.factory("StatisticsService", [
  "$http", "ContextService", function($http, ContextService) {
    return {
      getAll: function() {
        return $http({
          method: "GET",
          url: "/statistics"
        }).then(function(response) {
          return response.data;
        });
      },
      get: function(id) {
        return $http({
          method: "GET",
          url: "/statistics/" + id,
          params: {
            context: ContextService
          }
        }).then(function(response) {
          var data;
          data = response.data.spacial_statistics;
          return data;
        });
      }
    };
  }
]);
