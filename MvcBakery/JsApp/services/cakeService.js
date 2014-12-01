(function () {
    'use strict';

    var module = angular.module('cakeServices', []);

    module.factory('cakeService', ['$http', cakeService]);

    function cakeService($http) {
        //var url = '/api/products/';
        var url = 'http://bakeryapi.azurewebsites.net/api/pastry/';
        var service = {
            get: function () {
                return $http({ method: 'get', url: url });
            }
        };

        return service;
    }

    module.factory('orderService', ['$http', orderService]);
    function orderService($http) {
        //var url = 'http://bakeryapi.azurewebsites.net/api/pastry/';
        var url = '/api/orders/';
        var service = {
            get: function () {
                return $http.get(url);
            }
        };

        return service;
    }
})();