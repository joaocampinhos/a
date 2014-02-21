var app = angular.module("spacialAnalysis");

app.directive('hidesib', function() {
  return function (scope, element) {
    var hide = false;

    //bind on click para mudar essa margem
    element.bind('click',function(){
      hide = !hide;
      if (hide){
        element.parent().parent().parent().children().addClass("hide");
        element.parent().parent().removeClass("hide");
      }
      else{
        element.parent().parent().parent().children().removeClass("hide");
      }
    });

  };
});