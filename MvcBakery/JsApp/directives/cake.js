(function () {
    'use strict';
    var module = angular.module('bakeryDirectives', []);

    module.directive('cake', ['$window', cake]);
    function cake() {
        var directive = {
            restrict: 'AEC',
            templateUrl: '/JsApp/views/cakeView.html',
            scope: { product: '=ngModel' },
            controller: function ($scope) {
                //$scope.clicked = function () {
                //    //alert('Clicked');
                //};
            }
        };
        return directive;
    }






    module.directive('featuredCake', ['$window', featuredCake]);
    function featuredCake() {

        var directive = {
            restrict: 'AE',
            templateUrl: '/JsApp/views/featuredCakeView.html',
            transclude: true,
            scope: { featured: '=ngModel' }
        };
        return directive;
    }

})();