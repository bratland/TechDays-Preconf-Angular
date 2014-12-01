(function () {
    'use strict';

    var controllerId = 'cakeCtrl';

    angular.module('cakeControllers', []).controller(controllerId, ['$scope', 'cakeService', '$timeout', controller]);

    function controller($scope, cakeService, $timeout) {

        $scope.products = cakeService.getData();

        $scope.featured = $scope.products[Math.floor(Math.random() * $scope.products.length)];

        $scope.equalHeight = function() {
            $('.equalHeight').each(function() {
                var height = 0;
                $(this).find('.well').each(function() { height = Math.max(height, this.clientHeight); });
                $(this).find('.well').height(height);
            });
        };
    }
})();
