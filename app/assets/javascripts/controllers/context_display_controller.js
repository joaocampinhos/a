var app = angular.module("spacialAnalysis");

app.controller("contextDisplay", function($scope, ContextService) {
  $scope.context = ContextService; //Disponibilizar o contexto para ser mostrado ao utilizador na view
});