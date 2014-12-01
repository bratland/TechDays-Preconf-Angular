(function () {
    'use strict';

    var module = angular.module('orderControllers', []);

    module.controller('orderCtrl', ['$scope', 'orderService', controller]);

    function controller($scope, orderService) {

        $scope.orders = orderService.get().success(function(data) {
            $scope.orders = data;
        });

        var hub = $.connection.cakeHub;
        $.connection.hub.start();

        hub.client.addOrder = function (order) {
            $scope.orders.push(order);
            $scope.$apply();
        };

        $scope.closeOrder = function(order) {
            order.IsOpen = false;
        };
    }
})();
