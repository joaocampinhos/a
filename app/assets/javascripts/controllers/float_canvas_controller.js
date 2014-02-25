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
    $scope.name = result.name;
    switch(result.type){
      case 'value':
        $scope.chart = nvdFormatValueStats(result.stats);
      break;
      case 'frequency':
        $scope.charts = nvdFormatFrequencyStats(result.stats);
      break;
    }
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

  function nvdFormatFrequencyStats(stats){
    var charts = []
    var radius_values = _.keys(stats);
    _.each(radius_values, function(radius){
      var stat = stats[radius];
      var labels = _.sortBy(_.keys(stat), function(label){return parseFloat(label)});
      var chart = _.map(labels, function(label){
        return [label, stat[label]]
      });
      charts.push([{key: radius, values: chart}]);
    })
    console.log(stats);
    console.log(charts);
    return charts;
  }

  function nvd_format_value_stats(stats){
    var labels = _.sortBy(_.keys(stats), function(label){return parseFloat(label);});
    var values = _.map(labels, function(label){
      return [parseFloat(label), stats[label]];
    });
    return [{key: stats.name, values: values}];
  }
});