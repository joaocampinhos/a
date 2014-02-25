var app = angular.module("spacialAnalysis");

app.controller("floatCanvasController", function($scope) {
  $scope.chart = {
    labels : ["Cena1", "Cena2", "Cena3", "Cena4", "Cena5"],
    datasets : [
        {
            fillColor : "#a5a7a8",
            data : [4, 3, 5, 4, 6]
        },
        {
            fillColor : "#c5c4c3",
            data : [8, 3, 2, 5, 4]
        }
    ],
  };

  $scope.$on('statisticLoaded', function(event, result){
    console.log('Chart Draw')
    $scope.template = '/charts/'+result.type+'.html'
    $scope.chart = format_value_stats(result.stats)
  })

  function format_value_stats(stats){
    var labels = _.sortBy(_.keys(stats), function(label){return parseFloat(label)});
    var values = []
    _.each(labels, function(label){
      values.push(stats[label])
    })
    return { labels: labels, datasets: [ { fillColor : "#a5a7a8", data: values } ] };
  }

  function format_frequency_stats(stats){

  }
});