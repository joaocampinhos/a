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
});