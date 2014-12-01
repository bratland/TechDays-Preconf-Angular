(function() {
    'use strict';
    var module = angular.module('bakeryDirectives', []);

    module.directive('cake', ['$window', cake]);
    
    function cake () {

        var directive = {
            restrict: 'AE',
            templateUrl: '/JsApp/views/cakeView.html',
            transclude: true,
            scope: { product: '=ngModel' }
        };
        return directive;
    }

    module.directive('featuredCake', ['$window', featuredCake]);
    
    function featuredCake() {

        var directive = {
            restrict: 'AE',
            templateUrl: '/JsApp/views/featuredCakeView.html',
            transclude: true,
            scope: { product: '=ngModel' }
        };
        return directive;
    }

})();