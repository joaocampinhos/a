var app = angular.module("spacialAnalysis");

app.controller("floatCanvasController", function($scope) {

  $scope.showPnl = false;
  $scope.showBtn = false;
  $scope.$on('selected', function() {
    $scope.showPnl = false;
    $scope.showBtn = false;
  });

  $scope.toggle = function() {
    $scope.showPnl = !$scope.showPnl;
    $scope.showBtn = !$scope.showBtn;
  };

  $scope.$on('statisticLoaded', function(event, result){
    console.log('Chart Draw');
    $scope.showBtn = true;
    $scope.template = '/charts/'+result.type+'.html';
    $scope.chart = nvd_format_value_stats(result.stats);
  });

  $scope.yAxisThickFormat = function(){
    return function(val){
      return val.toFixed(3);
    };
  };

  function format_value_stats(stats){
    var labels = _.sortBy(_.keys(stats), function(label){return parseFloat(label);});
    var values = [];
    _.each(labels, function(label){
      values.push(+stats[label].toFixed(5));
    });
    return { labels: labels, datasets: [ { fillColor : "#a5a7a8", data: values } ] };
  }

  function format_frequency_stats(stats){

  }

  function nvd_format_value_stats(stats){
    var labels = _.sortBy(_.keys(stats), function(label){return parseFloat(label);});
    var values = _.map(labels, function(label){
      return [parseFloat(label), stats[label]];
    });
    return [{key: stats.name, values: values}];
  }
});