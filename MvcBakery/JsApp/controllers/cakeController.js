(function () {
    'use strict';

    var module = angular.module('cakeControllers', []);

    module.controller('cakeCtrl', ['$scope', 'cakeService', controller]);

    function controller($scope, cakeService) {

        $scope.products = {};

        cakeService.get()
            .success(function (data) {
                $scope.products = data;
                $scope.featured = $scope.products[Math.floor(Math.random() * $scope.products.length)];
            })
            .error(function (data, status) {
                console.log(data); console.log(status);
            });

    }
})();
