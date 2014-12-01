(function () {
    'use strict';

    angular.module('cakeServices',[]).factory('cakeService', ['$http', '$window', cakeService]);

    function cakeService($window) {
        var service = {
            getData: products
        };


        return service;
    }
})();