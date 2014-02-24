var app = angular.module("spacialAnalysis");


app.factory("DatasetService", ["$http", "$q", function($http, $q) {
  cache = {};
  return {
    getAll: function() {
      return $http({
        method: "GET",
        url: "/datasets"
      }).then(function(response) {
        return response.data;
      });
    },
    get: function(id) {
      var cachedData, deferred;
      cachedData = cache[id];
      if (cachedData) {
        deferred = $q.defer();
        deferred.resolve(cachedData);
        return deferred.promise;
      } else {
        return $http({
          method: "GET",
          url: "/datasets/" + id
        }).then(function(response) {
          var data;
          data = response.data;
          cache[id] = data;
          return data;
        });
      }
    }
  };
}]);
