(function () {
    'use strict';

    var id = 'app';

    // TODO: Inject modules as needed.
    var app = angular.module('app', [
        'cakeControllers',
        'cakeServices',
        'bakeryDirectives'
        
    ]);

    app.run(['$q', '$rootScope',
        function ($q, $rootScope) {

        }]);
})();