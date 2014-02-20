var app = angular.module("spacialAnalysis");

app.factory("StatisticsService", function($http) {
  return {
    getAll: function() {
      return $http({
        method: "GET",
        url: "/statistics"
      }).then(function(response) {
        return response.data;
      });
    },
    get: function(data) {
      return $http({
        method: "GET",
        url: "/statistics/" + data.dataset,
        params: {
          context: data
        }
      }).then(function(response) {
        return response.data;
      });
    }
  };
});
